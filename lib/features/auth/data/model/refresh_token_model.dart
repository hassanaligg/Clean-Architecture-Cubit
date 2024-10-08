class RefreshTokenModel {
  RefreshTokenModel({
    required this.mobileNumber,
    required this.token,
    required this.refreshToken,
    required this.id,
    required this.suffix,
    required this.name,
    required this.gender,
    required this.isProfileComplete,
  });

  final String? mobileNumber;
  final String? token;
  final String? refreshToken;
  final String? id;
  final String? suffix;
  final String? name;
  final int? gender;
  final bool? isProfileComplete;

  RefreshTokenModel copyWith({
    String? mobileNumber,
    String? token,
    String? refreshToken,
    String? id,
    String? suffix,
    String? name,
    int? gender,
    bool? isProfileComplete,
  }) {
    return RefreshTokenModel(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
      suffix: suffix ?? this.suffix,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json){
    return RefreshTokenModel(
      mobileNumber: json["mobileNumber"],
      token: json["token"],
      refreshToken: json["refreshToken"],
      id: json["id"],
      suffix: json["suffix"],
      name: json["name"],
      gender: json["gender"],
      isProfileComplete: json["isProfileComplete"],
    );
  }

  Map<String, dynamic> toJson() => {
    "mobileNumber": mobileNumber,
    "token": token,
    "refreshToken": refreshToken,
    "id": id,
    "suffix": suffix,
    "name": name,
    "gender": gender,
    "isProfileComplete": isProfileComplete,
  };

  @override
  String toString(){
    return "$mobileNumber, $token, $refreshToken, $id, $suffix, $name, $gender, $isProfileComplete, ";
  }
}
