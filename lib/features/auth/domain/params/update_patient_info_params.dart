import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UpdatePatientInfoParams {
  UpdatePatientInfoParams({
    required this.name,
    required this.gender,
    this.profilePhoto,
  });

  String name;
  int gender;
  String? profilePhoto;

  UpdatePatientInfoParams.empty()
      : name = '',
        gender = 0,
        profilePhoto = null;

  Future<Map<String, dynamic>> toJson() async {
    return {
      "name": name,
      "gender": gender,
      if (profilePhoto != null)
        "profilePhoto": await MultipartFile.fromFile(File(profilePhoto!).path,
            contentType:
                MediaType("image", File(profilePhoto!).path.split('/').last)),
    };
  }

  UpdatePatientInfoParams copyWith({
    String? name,
    int? gender,
    String? profilePhoto,
  }) {
    return UpdatePatientInfoParams(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
