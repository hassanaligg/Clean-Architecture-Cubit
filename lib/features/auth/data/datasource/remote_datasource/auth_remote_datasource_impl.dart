import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:dawaa24/features/auth/data/model/forgot_password_model.dart';
import 'package:dawaa24/features/auth/data/model/refresh_token_model.dart';
import 'package:dawaa24/features/auth/data/model/user_info.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import '../../../../../core/data/model/base_response_model.dart';
import '../../../../../core/data/model/nationality_model.dart';
import '../../../domain/params/update_patient_info_params.dart';
import '../../model/country_model.dart';
import '../../model/profile_model.dart';

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements AuthRemoteDataSource {
  String loginEndPoint = '${AppConstant.baseUrl}/api/app/auth/LogIn';
  String refreshTokenEndPoint =
      '${AppConstant.baseUrl}/api/app/Auth/RefreshToken';
  String logOutEndPoint = '${AppConstant.baseUrl}/api/app/Auth/LogOut';

  String loginVerifyOtpEndPoint =
      '${AppConstant.baseUrl}/api/app/auth/AuthenticateUser';
  String sendOtpEndPoint = '${AppConstant.baseUrl}/api/app/Auth/ResendOtp';

  String registerEndPoint =
      '${AppConstant.baseUrl}/api/services/app/User/CreateOrUpdateUserMobile';

  String nationalityEndPoint =
      '${AppConstant.baseUrl}/api/services/app/MobileNationalities/GetAllForMobile?MaxResultCount=100';
  String forgotPasswordEndPoint =
      '${AppConstant.baseUrl}/api/services/app/Account/ResetPasswordConfirmationMobile';
  String forgetPasswordVerifyOTPEndPoint =
      '${AppConstant.baseUrl}/api/services/app/MobileSMS/VerifyOTPCode';
  String getUserInfoEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/GetPatientInfo';
  String verifyMobileAndEmailEndPoint =
      '${AppConstant.baseUrl}/api/services/app/User/MobileNoEmailSignUpValidation';

  String verifyOtpEndPoint =
      '${AppConstant.baseUrl}/api/services/app/MobileSMS/VerifyOTPCode';
  String setNewPasswordEndPoint =
      '${AppConstant.baseUrl}/api/services/app/Account/ResetPasswordMobile';
  String changePasswordEndPoint =
      '${AppConstant.baseUrl}/api/services/app/Profile/ChangePassword';

  String getFlagsEndPoint =
      '${AppConstant.baseUrl}/api/app/lookup/GetCountryLookupAsync';
  String updatePatientInfoEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/UpdatePatientInfo';
  String changeLanguageEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/UpdateCurrentLanguage';

  AuthRemoteDataSourceImpl({required super.dio});

  @override
  Future<bool> login(Map<String, dynamic> body) async {
    final res = await post(
        url: loginEndPoint,
        body: body,
        decoder: (json) {},
        requiredToken: false);

    return res.status ?? false;
  }

  @override
  Future<BaseResponse<UserInfoModel>> loginVerifyOtp(
      Map<String, dynamic> body) async {
    final res = await post(
        url: loginVerifyOtpEndPoint,
        body: body,
        decoder: (json) => UserInfoModel.fromJson(json),
        requiredToken: false);

    return res;
  }

  @override
  Future<BaseResponse> sendOtp(Map<String, dynamic> body) async {
    final res = await post(
        url: sendOtpEndPoint,
        body: body,
        decoder: (json) {},
        requiredToken: false);
    return res;
  }

  @override
  Future<BaseResponse> register(Map<String, dynamic> body) async {
    final res = await post(
        url: registerEndPoint,
        body: body,
        decoder: (json) => {},
        requiredToken: false);

    return res;
  }

  @override
  Future<BaseResponse<Page<NationalityModel>>> getNationalities() async {
    final res = await get(
        url: nationalityEndPoint,
        decoder: (json) =>
            Page.fromJson(json, NationalityModel.fromJson, ListKeysPage.items),
        requiredToken: false);

    return res;
  }

  @override
  Future<BaseResponse<ProfileModel>> getUserInfo() async {
    final res = await get(
        url: getUserInfoEndPoint,
        decoder: (json) => ProfileModel.fromJson(json),
        requiredToken: true);

    return res;
  }

  @override
  Future<BaseResponse> logOut(String token) async {
    final res = await delete(
        url: logOutEndPoint,
        params: {'deviceToken': token},
        decoder: (json) => {},
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse<Map<String, dynamic>?>> verifyEmailAndPhoneNumber(
      Map<String, dynamic> body) async {
    final res = await post(
        url: verifyMobileAndEmailEndPoint,
        body: body,
        decoder: (json) => json == '{}' ? null : json as Map<String, dynamic>,
        requiredToken: false);
    return res;
  }

  @override
  Future<BaseResponse<Map<String, dynamic>?>> verifyOtp(
      Map<String, dynamic> body) async {
    final res = await post(
        url: verifyOtpEndPoint,
        body: body,
        decoder: (json) => <String, dynamic>{},
        requiredToken: false);
    return res;
  }

  @override
  Future<bool> setNewPassword(Map<String, dynamic> body) async {
    final res = await post(
        url: setNewPasswordEndPoint,
        body: body,
        decoder: (json) => {},
        requiredToken: false);
    return true;
  }

  @override
  Future<BaseResponse<ForgetPasswordModel>> forgetPassword(
      Map<String, dynamic> body) async {
    final res = await post(
        url: forgotPasswordEndPoint,
        body: body,
        decoder: (json) => ForgetPasswordModel.fromJson(json),
        requiredToken: false);

    return res;
  }

  @override
  Future<bool> forgetPasswordVerifyOTP(Map<String, dynamic> body) async {
    final res = await post(
        url: forgetPasswordVerifyOTPEndPoint,
        body: body,
        decoder: (json) => {},
        requiredToken: false);
    //todo
    return true;
  }

  @override
  Future<BaseResponse> changePassword(Map<String, dynamic> body) async {
    final res = await post(
        url: changePasswordEndPoint,
        body: body,
        decoder: (json) => {},
        requiredToken: false);
    return res;
  }

  @override
  Future<BaseResponse<Page<CountryModel>>> getCountries() async {
    final res = await get(
        url: getFlagsEndPoint,
        decoder: (json) {
          return Page.fromListJson(json, CountryModel.fromJson);
        });
    return res;
  }

  @override
  Future<BaseResponse<RefreshTokenModel>> refreshToken(
      Map<String, dynamic> body) async {
    final res = await post(
        url: refreshTokenEndPoint,
        decoder: (json) => RefreshTokenModel.fromJson(json),
        body: body);
    return res;
  }

  @override
  Future<BaseResponse> updatePatientInfo(UpdatePatientInfoParams params) async {
    final res = await putForm(
        url: updatePatientInfoEndPoint,
        body: await params.toJson(),
        decoder: (json) {},
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse> changeLanguage(Map<String, dynamic> params) async {
    final res = await put(
        url: changeLanguageEndPoint,
        params: params,
        decoder: (json) {},
        requiredToken: true);
    return res;
  }
}
