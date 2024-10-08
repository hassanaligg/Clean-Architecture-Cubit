class ForgetPasswordEntity {
  int? mobileUserId;
  String? resetCode;

  ForgetPasswordEntity({required this.mobileUserId, required this.resetCode});

  @override
  List<Object?> get props => [];
}
