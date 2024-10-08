import 'package:dawaa24/features/auth/data/model/forgot_password_model.dart';
import 'package:dawaa24/features/auth/data/model/refresh_token_model.dart';
import 'package:dawaa24/features/auth/data/model/user_info.dart';
import 'package:dawaa24/features/auth/domain/params/update_patient_info_params.dart';

import '../../../../../core/data/model/base_response_model.dart';
import '../../../../../core/data/model/nationality_model.dart';
import '../../model/country_model.dart';
import '../../model/profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login(Map<String, dynamic> body);

  Future<BaseResponse<UserInfoModel>> loginVerifyOtp(Map<String, dynamic> body);

  Future<BaseResponse<ForgetPasswordModel>> forgetPassword(
      Map<String, dynamic> body);

  Future<bool> forgetPasswordVerifyOTP(Map<String, dynamic> body);

  Future<BaseResponse<ProfileModel>> getUserInfo();

  Future<BaseResponse<Page<NationalityModel>>> getNationalities();

  Future<BaseResponse> register(Map<String, dynamic> body);

  Future<BaseResponse<Map<String, dynamic>?>> verifyEmailAndPhoneNumber(
      Map<String, dynamic> body);

  Future<BaseResponse> sendOtp(Map<String, dynamic> body);

  Future<BaseResponse<Map<String, dynamic>?>> verifyOtp(
      Map<String, dynamic> body);

  Future<bool> setNewPassword(Map<String, dynamic> body);

  Future<BaseResponse> logOut(String token);

  Future<BaseResponse> changePassword(Map<String, dynamic> body);

  Future<BaseResponse<Page<CountryModel>>> getCountries();

  Future<BaseResponse<RefreshTokenModel>> refreshToken(
      Map<String, dynamic> body);

  Future<BaseResponse> updatePatientInfo(UpdatePatientInfoParams params);

  Future<BaseResponse> changeLanguage(Map<String, dynamic> params);
}
