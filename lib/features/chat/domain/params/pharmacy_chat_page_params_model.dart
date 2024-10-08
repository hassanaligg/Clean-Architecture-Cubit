class PharmacyChatPageParamsModel {
  PharmacyChatPageParamsModel({
    required this.pharmacyName,
    required this.pharmacyId,
    required this.avatarUrl,
  });

  final String? pharmacyName;
  final String? pharmacyId;
  final String? avatarUrl;

  PharmacyChatPageParamsModel copyWith({
    String? pharmacyName,
    String? pharmacyId,
    String? avatarUrl,
  }) {
    return PharmacyChatPageParamsModel(
      pharmacyName: pharmacyName ?? this.pharmacyName,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory PharmacyChatPageParamsModel.fromJson(Map<String, dynamic> json){
    return PharmacyChatPageParamsModel(
      pharmacyName: json["pharmacyName"],
      pharmacyId: json["pharmacyId"],
      avatarUrl: json["avatarUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "pharmacyName": pharmacyName,
    "pharmacyId": pharmacyId,
    "avatarUrl": avatarUrl,
  };

  @override
  String toString(){
    return "$pharmacyName, $pharmacyId, $avatarUrl ";
  }
}
