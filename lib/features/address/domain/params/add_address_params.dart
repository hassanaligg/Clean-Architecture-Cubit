class AddAddressParams {
  String? name;
  String? buildingName;
  String? apartmentNumber;
  String? landmark;
  String? longitude;
  String? latitude;
  String? address;
  int? type;
  String? id;
  bool? isDefault;

  AddAddressParams({
    this.name,
    this.buildingName,
    this.apartmentNumber,
    this.landmark,
    this.longitude,
    this.latitude,
    this.address,
    this.type,
    this.id,
    this.isDefault,
  });

  factory AddAddressParams.empty() {
    return AddAddressParams(
      address: '',
      buildingName: '',
      latitude: null,
      longitude: null,
      type: 0,
      name: "",
      apartmentNumber: "",
      landmark: "",
      id: "0",
      isDefault: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'buildingName': buildingName,
      'appartmentNumber': apartmentNumber,
      'landmark': landmark,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'type': type,
      'id': id,
      if (isDefault != null) 'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return 'AddAddressParams{name: $name, buildingName: $buildingName, apartmentNumber: $apartmentNumber, landmark: $landmark, longitude: $longitude, latitude: $latitude, address: $address, type: $type}';
  }

  AddAddressParams copyWith({
    String? name,
    String? buildingName,
    String? apartmentNumber,
    String? landmark,
    String? longitude,
    String? latitude,
    String? address,
    int? type,
    String? id,
    bool? isDefault,

  }) {
    return AddAddressParams(
      name: name ?? this.name,
      buildingName: buildingName ?? this.buildingName,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      landmark: landmark ?? this.landmark,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      address: address ?? this.address,
      type: type ?? this.type,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
