import 'package:dawaa24/features/auth/domain/params/login_params.dart';

import '../../data/model/country_model.dart';
import '../../data/model/profile_model.dart';
import '../params/update_patient_info_params.dart';

abstract class AuthRepository {
  Future<bool> login(Map<String, dynamic> body);

  Future<bool> loginVerifyOtp(LoginParams body);

  Future<ProfileModel> loadRemoteUserInfo();

  Future<bool> sendOtp(Map<String, dynamic> body);

  Future<bool> logOut({bool withToken});

  Future<String> getLocalToken();

  Future<String> getLocalLang();

  Future<bool> setLangKey(String key);

  Future<String> checkToken();

  Future<List<CountryModel>> getCountries();

  Future<bool> refreshToken();

  Future<bool> updatePatientInfo(UpdatePatientInfoParams params);

  Future<bool> changeLanguage(Map<String, dynamic> params);

/*
  Future<List<NationalityModel>> getNationalities();

  Future<BaseResponse> register(Map<String, dynamic> body);

  Future<BaseResponse<Map<String, dynamic>?>> verifyEmailAndPhoneNumber(
      Map<String, dynamic> body);

  Future<BaseResponse<Map<String, dynamic>?>> sendOtp(
      Map<String, dynamic> body);

  Future<BaseResponse<Map<String, dynamic>?>> verifyOtp(
      Map<String, dynamic> body);

  Future<ForgetPasswordModel> forgetPassword(Map<String, dynamic> body);

  Future<bool> forgetPasswordOtp(Map<String, dynamic> body);

  Future<bool> forgetPasswordSetPassword(Map<String, dynamic> body);

  Future<void> saveLoginParams(LoginParams body);

  Future<LoginParams> getLogInParamBiometrics();

  Future<bool> checkIfDeviceHasBiometrics();

  Future<BaseResponse> changePassword(Map<String, dynamic> body);*/
}
