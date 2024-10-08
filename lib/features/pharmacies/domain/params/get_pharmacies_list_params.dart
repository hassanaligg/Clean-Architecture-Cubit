class GetPharmaciesListParamsModel {
  GetPharmaciesListParamsModel({
    required this.filterText,
    required this.sorting,
    required this.skipCount,
    required this.maxResultCount,
  });

  final String? filterText;
  final PharmacySortingEnum? sorting;
  final int skipCount;
  final int maxResultCount;

  factory GetPharmaciesListParamsModel.empty() {
    return GetPharmaciesListParamsModel(
        skipCount: 0, maxResultCount: 10, filterText: null, sorting: null);
  }

  GetPharmaciesListParamsModel copyWith({
    String? filterText,
    PharmacySortingEnum? sorting,
    int? skipCount,
    int? maxResultCount,
  }) {
    return GetPharmaciesListParamsModel(
      filterText: filterText ?? this.filterText,
      sorting: sorting ?? this.sorting,
      skipCount: skipCount ?? this.skipCount,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filterText != null) data['FilterText'] = filterText;
    if (sorting != null) data['Sorting'] = sorting!.displayName();
    data["SkipCount"] = skipCount;
    data["MaxResultCount"] = maxResultCount;
    return data;
  }

  @override
  String toString() {
    return "$filterText,$skipCount, $maxResultCount, ";
  }
}

enum PharmacySortingEnum { addingDate_asc, addingDate_desc }

extension MyEnumExtension on PharmacySortingEnum {
  String displayName() {
    return name.replaceAll('_', ' ');
  }
}
