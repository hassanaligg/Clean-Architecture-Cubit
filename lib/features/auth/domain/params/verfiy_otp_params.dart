class VerifyOtpParams {
  String mobileNumber;
  String otp;

  VerifyOtpParams({required this.mobileNumber, required this.otp});

  Map<String, dynamic> toJson() =>
      {"mobileNumber": mobileNumber, "OTPCode": otp};
}
