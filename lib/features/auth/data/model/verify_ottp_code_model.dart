/*
class VerifyOtpCodeModel {
  VerifyOtpCodeModel({
    required String mobileNumber,
    required num otpCode,
  }) {
    _mobileNumber = mobileNumber;
    _otpCode = otpCode;
  }

  VerifyOtpCodeModel.fromJson(dynamic json) {
    _mobileNumber = json['mobileNumber'];
    _otpCode = json['otpCode'];
  }

  String? _mobileNumber;
  num? _otpCode;

  VerifyOtpCodeModel copyWith({
    required String mobileNumber,
    required num otpCode,
  }) =>
      VerifyOtpCodeModel(
        mobileNumber: mobileNumber,
        otpCode: otpCode,
      );

  String? get mobileNumber => _mobileNumber;

  num? get otpCode => _otpCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileNumber'] = _mobileNumber;
    map['otpCode'] = _otpCode;
    return map;
  }
}
*/
