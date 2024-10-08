import 'package:dawaa24/core/data/datasource/base_local_datasource.dart';
import 'package:dawaa24/core/utils/failures/local_storage/local_storage_failure.dart';
import 'package:dawaa24/features/auth/data/model/user_info.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/shared_prefrences_keys.dart';

abstract class AuthLocalDataSource {
  String? getToken();

  String? getLocalLang();

  String? getRefreshToken();

  Future<String?> getAgoraUserId();

  Future<bool> storeToken(String token, String reFreshToken);

  Future<bool> setLangKey(String key);

  Future<bool> storeUserInfo(UserInfoModel userInfoModel);

  Future<UserInfoModel> getUserInfo();

  Future<bool> deleteToken();

  Future<bool> deleteAccountStatus();

  Future<bool> deleteAddress();

  Future<bool> clearShared();

  Future<String> getEmail();

  Future<bool> hasDataInBiometricsData();

  Future<bool> storeAccountStatus(bool status);

  Future<bool> checkAccountStatus();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImp extends BaseLocalDataSourceImp
    implements AuthLocalDataSource {
  AuthLocalDataSourceImp(super.sharedPreferences);

  @override
  String? getToken() {
    final result = sharedPreferences.getString(SharedPreferencesKeys.token);
    return result;
  }

  @override
  String? getLocalLang() {
    final result =
        sharedPreferences.getString(SharedPreferencesKeys.langKey) ?? "en";
    return result;
  }

  @override
  String? getRefreshToken() {
    final result =
        sharedPreferences.getString(SharedPreferencesKeys.reFreshToken);
    return result;
  }

  @override
  Future<bool> storeToken(String token, String reFreshToken) async {
    final result =
        await sharedPreferences.setString(SharedPreferencesKeys.token, token);
    await sharedPreferences.setString(
        SharedPreferencesKeys.reFreshToken, reFreshToken);
    return result;
  }

  @override
  Future<bool> deleteToken() async {
    final result = await sharedPreferences.remove(SharedPreferencesKeys.token);
    return result;
  }

  @override
  Future<bool> deleteAddress() async {
    final result =
        await sharedPreferences.remove(SharedPreferencesKeys.localAddress);
    return result;
  }

  @override
  Future<UserInfoModel> getUserInfo() {
    final resultJson =
        sharedPreferences.getString(SharedPreferencesKeys.userInfo);
    if (resultJson == null || resultJson.isEmpty) {
      throw DataNotExistFailure();
    } else {
      final UserInfoModel result =
          UserInfoModel.fromRawJson(resultJson.toLowerCase());
      return Future.value(result);
    }
  }

  @override
  Future<bool> storeUserInfo(UserInfoModel userInfoModel) async {
    final result = await sharedPreferences.setString(
        SharedPreferencesKeys.userInfo, userInfoModel.toRawJson());
    return result;
  }

  @override
  Future<String> getEmail() async {
    return (sharedPreferences.getString(SharedPreferencesKeys.email))!;
  }

  @override
  Future<bool> hasDataInBiometricsData() async {
    if (sharedPreferences.getString(SharedPreferencesKeys.email) != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String?> getAgoraUserId() async {
    var temp = await getUserInfo();
    return (temp.id ?? '') + (temp.suffix ?? '');
  }

  @override
  Future<bool> checkAccountStatus() async {
    if (sharedPreferences.containsKey(SharedPreferencesKeys.accountStatus)) {
      return sharedPreferences.getBool(SharedPreferencesKeys.accountStatus)!;
    } else {
      return false;
    }
  }

  @override
  Future<bool> storeAccountStatus(bool status) async {
    final result = await sharedPreferences.setBool(
        SharedPreferencesKeys.accountStatus, status);
    return result;
  }

  @override
  Future<bool> deleteAccountStatus() async {
    final result =
        await sharedPreferences.remove(SharedPreferencesKeys.accountStatus);
    return result;
  }

  @override
  Future<bool> setLangKey(String key)async {
    var lang =await sharedPreferences.setString(SharedPreferencesKeys.langKey, key);

    return lang;
  }

  @override
  Future<bool> clearShared() {
    return sharedPreferences.clear();
  }
}
