part of 'quick_register_cubit.dart';

enum QuickRegisterStatus {
  initial,
  loading,
  getCountriesLoading,
  getCountriesSuccess,
  error,
  sendOtpSuccess,
  success,
  verifyOtpSuccess,
  resendOtpSuccess,
  verifyOtpError
}

class QuickRegisterState {
  final QuickRegisterStatus status;
  final Failure? failure;
  final PhoneNumberModel? phoneNumberModel;
  final bool validateField;
  final String otp;
  final List<CountryModel>? countries;
  final int? selectedGender;

  GlobalKey<FormState> formKey;

  QuickRegisterState._({
    required this.status,
    required this.phoneNumberModel,
    this.validateField = false,
    required this.formKey,
    required this.otp,
    this.failure,
    this.countries,
    this.selectedGender,
  });

  QuickRegisterState.initial()
      : status = QuickRegisterStatus.initial,
        phoneNumberModel = PhoneNumberModel.initial(),
        validateField = false,
        otp = '',
        selectedGender = 0,
        formKey = GlobalKey<FormState>(),
        countries = [],
        failure = null;

  QuickRegisterState phoneNumberChanged(String phoneNumber) {
    return copyWith(
      phoneNumberModel: phoneNumberModel!.copyWith(phoneNumber: phoneNumber),
    );
  }

  QuickRegisterState enableValidation() {
    return copyWith(validateField: true);
  }

  QuickRegisterState disableValidation() {
    return copyWith(
      validateField: false,
      formKey: GlobalKey<FormState>(),
    );
  }

  QuickRegisterState changeState(QuickRegisterStatus status) {
    return copyWith(status: status);
  }

  copyWith(
      {QuickRegisterStatus? status,
      Failure? failure,
      bool? validateField,
      String? otp,
      GlobalKey<FormState>? formKey,
      List<CountryModel>? countries,
      int? selectedGender,
      PhoneNumberModel? phoneNumberModel}) {
    return QuickRegisterState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      otp: otp ?? this.otp,
      formKey: formKey ?? this.formKey,
      selectedGender: selectedGender ?? this.selectedGender,
      countries: countries ?? this.countries,
      validateField: validateField ?? this.validateField,
      phoneNumberModel: phoneNumberModel ?? this.phoneNumberModel,
    );
  }
}
