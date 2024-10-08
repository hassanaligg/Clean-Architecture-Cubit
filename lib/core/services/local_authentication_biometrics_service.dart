import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@Singleton()
class LocalAuthenticationBiometricsService {
  final LocalAuthentication authentication = LocalAuthentication();

  Future<bool> checkIfHasBiometrics() async{
    bool hasBiometrics = false;
   await authentication.canCheckBiometrics
        .then((can) => authentication.isDeviceSupported().then((supported) {
          hasBiometrics = can & supported;
          return hasBiometrics;
            }));
    return hasBiometrics;
  }

  Future<bool> callBiometricsAndCheckResult() async {
    if (await authentication.authenticate(
      localizedReason: 'sign_in.biometrics_permission'.tr(),
    )) {
      return true;
    }
    return false;
  }
}
