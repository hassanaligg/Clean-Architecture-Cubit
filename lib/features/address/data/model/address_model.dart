class AddressModel {
  String? name;
  String? buildingName;
  String? apartmentNumber;
  String? landmark;
  double? longitude;
  double? latitude;
  String? address;
  int? type;
  bool? isDefault;
  bool? isActive;
  String? id;

  AddressModel(
      {this.name,
        this.buildingName,
        this.apartmentNumber,
        this.landmark,
        this.longitude,
        this.latitude,
        this.address,
        this.type,
        this.isDefault,
        this.isActive,
        this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buildingName = json['buildingName']??"";
    apartmentNumber = json['appartmentNumber']??"";
    landmark = json['landmark']??"";
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    type = json['type'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['buildingName'] = buildingName;
    data['appartmentNumber'] = apartmentNumber;
    data['landmark'] = landmark;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
