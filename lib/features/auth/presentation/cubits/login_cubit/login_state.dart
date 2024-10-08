/*
part of 'login_cubit.dart';

enum LoginStatus { initial, loading, error, success }

class LoginState {
  final LoginStatus status;
  final LoginParams params;
  final Failure? loginFailure;
  final bool validateField;
  GlobalKey<FormState> formKey;
  final bool isHidden;
  final bool saveInfoWithBiometrics;
  final bool hasBiometrics; //if device has fingerprint or password
  final bool hasBiometricsData; //if user has saved credential
  String whatsappMobileNumber = AppConstant.whatsappMobileNumber;
  String whatsappURl = "whatsapp://send?phone=";
  final List<BiometricType> availableBiometrics;

  LoginState._({
    required this.status,
    required this.params,
    this.loginFailure,
    this.validateField = false,
    required this.formKey,
    this.isHidden = true,
    this.hasBiometrics = false,
    this.hasBiometricsData = false,
    this.saveInfoWithBiometrics = false,
    required this.availableBiometrics,
  });

  LoginState.initial()
      : status = LoginStatus.initial,
        params = LoginParams.empty(),
        loginFailure = null,
        validateField = false,
        formKey = GlobalKey<FormState>(),
        saveInfoWithBiometrics = false,
        hasBiometrics = false,
        hasBiometricsData = false,
        isHidden = true,
        availableBiometrics = [];

  LoginState emailChanged(String newEmail) {
    return copyWith(
      params: params.copyWith(e: newEmail),
    );
  }

  LoginState changeState(LoginStatus status) {
    return copyWith(status: status);
  }

  LoginState changeHasBiometrics(bool value) {
    return copyWith(hasBiometrics: value);
  }

  LoginState passwordChanged(String newPassword) {
    return copyWith(
      params: params.copyWith(p: newPassword),
    );
  }

  LoginState loginError(Failure failure) {
    return copyWith(status: LoginStatus.error, loginFailure: failure);
  }

  LoginState enableValidation() {
    return copyWith(validateField: true);
  }

  copyWith({
    LoginStatus? status,
    LoginParams? params,
    Failure? loginFailure,
    bool? validateField,
    bool? isHidden,
    bool? saveInfoWithBiometrics,
    bool? hasBiometrics,
    bool? hasBiometricsData,
    List<BiometricType>? availableBiometrics,
  }) {
    return LoginState._(
        status: status ?? this.status,
        params: params ?? this.params,
        formKey: formKey,
        loginFailure: loginFailure ?? this.loginFailure,
        validateField: validateField ?? this.validateField,
        isHidden: isHidden ?? this.isHidden,
        hasBiometrics: hasBiometrics ?? this.hasBiometrics,
        hasBiometricsData: hasBiometricsData ?? this.hasBiometricsData,
        saveInfoWithBiometrics:
            saveInfoWithBiometrics ?? this.saveInfoWithBiometrics,
        availableBiometrics: availableBiometrics ?? this.availableBiometrics);
  }
}
*/
