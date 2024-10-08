class ChangePasswordParams {
  ChangePasswordParams({
    required this.currentPassword,
    required this.firstPassword,
    required this.secondPassword,
  });

  String currentPassword;
  String firstPassword;
  String secondPassword;

  ChangePasswordParams.empty()
      : currentPassword = '',
        firstPassword = '',
        secondPassword = '';

  Map<String, dynamic> toJson() => {
        "currentPassword": currentPassword,
        "newPassword": firstPassword,
      };

  ChangePasswordParams copyWith({
    String? currentPassword,
    String? firstPassword,
    String? secondPassword,
  }) {
    return ChangePasswordParams(
      currentPassword: currentPassword ?? this.currentPassword,
      firstPassword: firstPassword ?? this.firstPassword,
      secondPassword: secondPassword ?? this.secondPassword,
    );
  }
}
