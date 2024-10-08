class LoginModel {
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? shouldResetPassword;
  dynamic passwordResetCode;
  int? userId;
  bool? requiresTwoFactorVerification;
  dynamic twoFactorAuthProviders;
  dynamic twoFactorRememberClientToken;
  String? returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;
  bool? isRemember;

  set setIsRemember(bool isRemember) {
    this.isRemember = isRemember;
  }

  LoginModel(
      {this.accessToken,
      this.encryptedAccessToken,
      this.expireInSeconds,
      this.shouldResetPassword,
      this.passwordResetCode,
      this.userId,
      this.requiresTwoFactorVerification,
      this.twoFactorAuthProviders,
      this.twoFactorRememberClientToken,
      this.returnUrl,
      this.refreshToken,
      this.refreshTokenExpireInSeconds});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    encryptedAccessToken = json['encryptedAccessToken'];
    expireInSeconds = json['expireInSeconds'];
    shouldResetPassword = json['shouldResetPassword'];
    //passwordResetCode = json['passwordResetCode'];
    userId = json['userId'];
    requiresTwoFactorVerification = json['requiresTwoFactorVerification'];
    //twoFactorAuthProviders = json['twoFactorAuthProviders'];
    //twoFactorRememberClientToken = json['twoFactorRememberClientToken'];
    returnUrl = json['returnUrl'];
    refreshToken = json['refreshToken'];
    refreshTokenExpireInSeconds = json['refreshTokenExpireInSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['encryptedAccessToken'] = encryptedAccessToken;
    data['expireInSeconds'] = expireInSeconds;
    data['shouldResetPassword'] = shouldResetPassword;
    //data['passwordResetCode'] = passwordResetCode;
    data['userId'] = userId;
    data['requiresTwoFactorVerification'] = requiresTwoFactorVerification;
    //data['twoFactorAuthProviders'] = twoFactorAuthProviders;
    //data['twoFactorRememberClientToken'] = twoFactorRememberClientToken;
    data['returnUrl'] = returnUrl;
    data['refreshToken'] = refreshToken;
    data['refreshTokenExpireInSeconds'] = refreshTokenExpireInSeconds;
    return data;
  }
}
