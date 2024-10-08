class PostLoginModel {
  PostLoginModel({
    required this.UserNameOrEmailAddress,
    required this.password,
  });
  late final String UserNameOrEmailAddress;
  late final String password;

  PostLoginModel.fromJson(Map<String, dynamic> json){
    UserNameOrEmailAddress = json['UserNameOrEmailAddress'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['UserNameOrEmailAddress'] = UserNameOrEmailAddress;
    data['password'] = password;
    return data;
  }
}