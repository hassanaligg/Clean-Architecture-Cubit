class SendOtpParams {
  String mobile;
  bool isOtp;
  bool isForCreateVerification;
  bool sendImmediatly;

  SendOtpParams(this.mobile,
      {this.isOtp = true, this.isForCreateVerification = true, this.sendImmediatly = true});

  Map<String, dynamic> toJson() => {
        "message": "this message not important in this api, dawaa24 build otp message",
        "mobileNumber": mobile.trim(),
        "isOTP": isOtp,
        "isForCreateVerification": isForCreateVerification,
        "sendImmediatly": sendImmediatly
      };
}
