class VerifyPhoneNumberAndEmailParams {
  String mobile;
  String email;
  VerifyPhoneNumberAndEmailParams({required this.email, required this.mobile});

  Map<String, dynamic> toJson() => {
        "emailAddress": email,
        "mobileNo": mobile,
        "langCode": "en",
      };
}
