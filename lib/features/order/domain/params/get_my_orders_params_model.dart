class GetMyOrdersParamsModel {
  GetMyOrdersParamsModel({
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  GetMyOrdersParamsModel copyWith({
    String? sorting,
    int? skipCount,
    int? maxResultCount,
  }) {
    return GetMyOrdersParamsModel(
      sorting: sorting ?? this.sorting,
      skipCount: skipCount ?? this.skipCount,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }

  factory GetMyOrdersParamsModel.fromJson(Map<String, dynamic> json){
    return GetMyOrdersParamsModel(
      sorting: json["Sorting"],
      skipCount: json["SkipCount"],
      maxResultCount: json["MaxResultCount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Sorting": sorting,
    "SkipCount": skipCount,
    "MaxResultCount": maxResultCount,
  };

  @override
  String toString(){
    return "$sorting, $skipCount, $maxResultCount, ";
  }
}
