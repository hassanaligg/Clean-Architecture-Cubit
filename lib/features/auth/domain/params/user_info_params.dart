class UserInfoParams {
  int userId;

  UserInfoParams(this.userId);

  Map<String, dynamic> toJson() => {
        "id": userId,
      };
}
