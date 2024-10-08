import 'dart:convert';

class GetAddressListParams {
  String? filterText;
  String? name;
  String? buildingName;
  String? apartmentNumber;
  String? landmark;
  String? longitude;
  String? latitude;
  int? type;
  String? sorting;
  int? skipCount;
  int? maxResultCount;

  GetAddressListParams({
    this.filterText,
    this.name,
    this.buildingName,
    this.apartmentNumber,
    this.landmark,
    this.longitude,
    this.latitude,
    this.type,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  Map<String, dynamic> toJson() {
    return {
      if (filterText != null) 'FilterText': filterText,
      if (name != null) 'Name': name,
      if (buildingName != null) 'BuildingName': buildingName,
      if (apartmentNumber != null) 'AppartmentNumber': apartmentNumber,
      if (landmark != null) 'Landmark': landmark,
      if (longitude != null) 'Longitude': longitude,
      if (latitude != null) 'Latitude': latitude,
      if (type != null) 'Type': type,
      if (sorting != null) 'Sorting': sorting,
      if (skipCount != null) 'SkipCount': skipCount,
      if (maxResultCount != null) 'MaxResultCount': maxResultCount,
    };
  }
}
