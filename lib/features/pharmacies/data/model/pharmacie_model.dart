import 'package:dawaa24/features/pharmacies/data/model/working_time_model.dart';

class PharmacyModel {
  PharmacyModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.profileImage,
    required this.bannarImage,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.workingTimes,
    required this.addingDate,
    required this.distance,
    required this.distanceUnit,
    required this.isComingFromQr,
  });

  final String id;
  final String name;
  final String phone;
  final String? profileImage;
  final String? bannarImage;
  final double longitude;
  final double latitude;
  final String address;
  final DateTime? addingDate;
  final double? distance;
  final String? distanceUnit;
  final bool isComingFromQr;
  final List<WorkingTimeModel> workingTimes;

  PharmacyModel copyWith(
      {String? id,
      String? name,
      String? phone,
      String? profileImage,
      String? bannarImage,
      double? longitude,
      double? latitude,
      String? address,
      double? distance,
      String? distanceUnit,
      List<WorkingTimeModel>? workingTimes,
      DateTime? addingDate,
      bool? isComingFromQr}) {
    return PharmacyModel(
      id: id ?? this.id,
      isComingFromQr: isComingFromQr ?? this.isComingFromQr,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      distance: distance ?? this.distance,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      profileImage: profileImage ?? this.profileImage,
      bannarImage: bannarImage ?? this.bannarImage,
      longitude: longitude ?? this.longitude,
      addingDate: addingDate ?? this.addingDate,
      latitude: latitude ?? this.latitude,
      address: address ?? this.address,
      workingTimes: workingTimes ?? this.workingTimes,
    );
  }

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    
    return PharmacyModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      isComingFromQr: false,
      distance: json["distance"] != null ? json["distance"].toDouble() : 0.0,
      distanceUnit: json["distance_unit"],
      addingDate: DateTime.tryParse(json["addingDate"] ?? ""),
      phone: json["phone"] ?? "",
      bannarImage: json["bannarImage"] ?? "",
      profileImage: json["profileImage"] ?? "",
      longitude: json["longitude"] ?? "",
      latitude: json["latitude"] ?? "",
      address: json["address"] ?? "",
      workingTimes: json["workingTimes"] == null
          ? []
          : List<WorkingTimeModel>.from(
              json["workingTimes"]!.map((x) => WorkingTimeModel.fromJson(x))),
    );
  }


  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "distance": distance,
        "distance_unit": distanceUnit,
        "phone": phone,
        "bannarImage": bannarImage,
        "profileImage": profileImage,
        "longitude": longitude,
        "addingDate": addingDate?.toIso8601String(),
        "latitude": latitude,
        "address": address,
        "workingTimes": workingTimes.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $name, $phone,$distance, $distanceUnit, $longitude, $latitude, $address, $workingTimes, ";
  }
}
