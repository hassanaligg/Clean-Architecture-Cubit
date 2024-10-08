class LoginParams {
  LoginParams({
    required this.countryCode,
    required this.mobileNumber,
    this.deviceToken,
    this.code,
  });

  final String countryCode;
  final String mobileNumber;
  final String? code;
  final String? deviceToken;

  LoginParams copyWith(
      {String? countryCode,
      String? mobileNumber,
      String? code,
      String? deviceToken}) {
    return LoginParams(
      deviceToken: deviceToken ?? this.deviceToken,
      countryCode: countryCode ?? this.countryCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        if (code != null) "deviceToken": deviceToken,
        if (code != null) "code": code,
      };

  @override
  String toString() {
    return "$countryCode, $mobileNumber, $code,$deviceToken ";
  }
}
