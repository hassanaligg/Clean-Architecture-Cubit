class RefreshTokenRequestModel {
  RefreshTokenRequestModel({
    required this.refreshToken,
  });

  final String? refreshToken;

  RefreshTokenRequestModel copyWith({
    String? refreshToken,
  }) {
    return RefreshTokenRequestModel(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json){
    return RefreshTokenRequestModel(
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
  };

  @override
  String toString(){
    return "$refreshToken, ";
  }
}
