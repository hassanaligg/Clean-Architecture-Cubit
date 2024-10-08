import 'package:dawaa24/core/data/enums/auth_state.dart';
import 'package:dawaa24/core/data/repository/push_notification_repository.dart';
import 'package:dawaa24/core/utils/failures/local_storage/local_storage_failure.dart';
import 'package:dawaa24/core/utils/handler/auth_handler.dart';
import 'package:dawaa24/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:dawaa24/features/auth/data/model/refresh_token_request_model.dart';
import 'package:dawaa24/features/auth/domain/params/login_params.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/datasource/shared_prefrences_keys.dart';
import '../../../../core/data/model/base_response_model.dart';
import '../../../../core/data/network/network_Info.dart';
import '../../../../core/services/agora_service.dart';
import '../../../../core/utils/failures/http/http_failure.dart';
import '../../../../di/injection.dart';
import '../../domain/params/update_patient_info_params.dart';
import '../datasource/remote_datasource/auth_remote_datasource.dart';
import '../model/country_model.dart';
import '../model/profile_model.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final AuthHandler authHandler;
  late String? token;
  late AgoraService _agoraService;
  final PushNotificationRepository pushNotificationRepository;
  late NetworkInfo _networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.authLocalDataSource,
      this.authHandler, this.pushNotificationRepository) {
    token = authLocalDataSource.getToken();
    _agoraService = getIt<AgoraService>();
    _networkInfo = getIt<NetworkInfo>();
  }

  @override
  Future<bool> login(Map<String, dynamic> body) async {
    final bool res = await remoteDataSource.login(body);
    return res;
  }

  @override
  Future<bool> loginVerifyOtp(LoginParams body) async {
    body = body.copyWith(
        deviceToken: await pushNotificationRepository.getFireBaseTokenString());
    final res = await remoteDataSource.loginVerifyOtp(body.toJson());
    authLocalDataSource.storeToken(
        res.data!.token ?? '', res.data!.refreshToken ?? '');
    authLocalDataSource.storeUserInfo(res.data!);
    token = res.data?.token;
    if (res.data!.isProfileComplete ?? false) {
      authLocalDataSource.storeAccountStatus(true);
      authHandler.changeAuthState(AuthState.authenticated);
    } else {
      authHandler.changeAuthState(AuthState.notVerified);
    }
    return res.status ?? false;
  }

  @override
  Future<bool> sendOtp(Map<String, dynamic> body) async {
    final res = await remoteDataSource.sendOtp(body);
    return res.status ?? false;
  }

  @override
  Future<String> checkToken() async {
    if (!await _networkInfo.isConnected) {
      throw const NoInternetFailure();
    }
    token = authLocalDataSource.getToken();
    if (token == null) {
      authHandler.changeAuthState(AuthState.unAuthenticated);
      throw (DataNotExistFailure());
    } else {
      if (await authLocalDataSource.checkAccountStatus()) {
        await _agoraService.initSDK();
        authHandler.changeAuthState(AuthState.authenticated);
      } else {
        authHandler.changeAuthState(AuthState.notVerified);
      }
      return Future.value((token));
    }
  }

  @override
  Future<ProfileModel> loadRemoteUserInfo() async {
    final BaseResponse<ProfileModel> res = await remoteDataSource.getUserInfo();
    // authLocalDataSource.storeUserInfo(res.data!);
    return res.data!;
  }

  @override
  Future<String> getLocalToken() {
    token = authLocalDataSource.getToken();

    if (token == null) {
      throw (DataNotExistFailure());
    } else {
      return Future.value((token));
    }
  }

  @override
  Future<String> getLocalLang() {
    var lang = authLocalDataSource.getLocalLang();
    return Future.value((lang));
  }

  @override
  Future<bool> setLangKey(String key) {
    var lang = authLocalDataSource.setLangKey(key);
    return Future.value((lang));
  }

  @override
  Future<bool> logOut({bool withToken = false}) async {
    if (withToken) {
      await remoteDataSource
          .logOut(await pushNotificationRepository.getFireBaseTokenString());
    }
    var lang = authLocalDataSource.getLocalLang();

    await authLocalDataSource.deleteToken();
    await authLocalDataSource.deleteAddress();
    await authLocalDataSource.deleteAccountStatus();
    await authLocalDataSource.setLangKey(lang!);

    ///delete cached token from dio
    authHandler.changeAuthState(AuthState.unAuthenticated);
    return (true);
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    final res = await remoteDataSource.getCountries();

    return res.data!.list;
  }

  @override
  Future<bool> refreshToken() async {
    final res = await remoteDataSource.refreshToken(RefreshTokenRequestModel(
            refreshToken: authLocalDataSource.getRefreshToken())
        .toJson());
    authLocalDataSource.storeToken(
        res.data!.token ?? '', res.data!.refreshToken ?? '');
    //todo
    token = res.data?.token;
    return res.status ?? false;
  }

  @override
  Future<bool> updatePatientInfo(UpdatePatientInfoParams params) async {
    final res = await remoteDataSource.updatePatientInfo(params);
    authLocalDataSource.storeAccountStatus(true);
    authHandler.changeAuthState(AuthState.authenticated);
    return res.status ?? false;
  }

  @override
  Future<bool> changeLanguage(Map<String, dynamic> params) async {
    final res = await remoteDataSource.changeLanguage(params);
    return res.status ?? false;
  }

/*
  @override
  Future<List<NationalityModel>> getNationalities() async {
    final res = await remoteDataSource.getNationalities();

    return res.data!.list;
  }

  @override
  Future<BaseResponse> register(Map<String, dynamic> body) async {
    final BaseResponse res = await remoteDataSource.register(body);

    // baseLocalDataSource.storeToken(res.data?.accessToken ?? '');
    // authHandler.changeAuthState(AuthState.authenticated);
    return res;
  }

  @override
  Future<BaseResponse<Map<String, dynamic>?>> verifyEmailAndPhoneNumber(
      Map<String, dynamic> body) async {
    final res = await remoteDataSource.verifyEmailAndPhoneNumber(body);

    return res;
  }

  @override
  Future<BaseResponse<Map<String, dynamic>?>> sendOtp(
      Map<String, dynamic> body) async {
    final res = await remoteDataSource.sendOtp(body);

    return res;
  }

  @override
  Future<BaseResponse<Map<String, dynamic>?>> verifyOtp(
      Map<String, dynamic> body) async {
    final res = await remoteDataSource.verifyOtp(body);

    return res;
  }

  @override
  Future<bool> forgetPasswordOtp(Map<String, dynamic> body) async {
    final res = await remoteDataSource.forgetPasswordVerifyOTP(body);
    return res;
  }

  @override
  Future<bool> forgetPasswordSetPassword(Map<String, dynamic> body) async {
    final res = await remoteDataSource.setNewPassword(body);
    return res;
  }

  @override
  Future<void> saveLoginParams(LoginParams body) async {
    authLocalDataSource.savePasswordAndEmail(body.email, body.password);
  }

  @override
  Future<LoginParams> getLogInParamBiometrics() async {
    var mail = await authLocalDataSource.getEmail();
    var password = await authLocalDataSource.getPassword();
    LoginParams loginParamsTemp = LoginParams(mail, password);
    return loginParamsTemp;
  }

  @override
  Future<bool> checkIfDeviceHasBiometrics() async {
    return await authLocalDataSource.hasDataInBiometricsData();
  }

  @override
  Future<BaseResponse> changePassword(Map<String, dynamic> body) async {
    return await remoteDataSource.changePassword(body);
  }*/
}
