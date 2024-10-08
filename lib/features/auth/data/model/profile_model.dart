class ProfileModel {
  int? gender;
  String? name;
  String? countryCode;
  String? addressName;
  String? mobileNumber;
  String? profilePhoto;

  ProfileModel(
      {this.gender,
        this.name,
        this.countryCode,
        this.addressName,
        this.mobileNumber,
        this.profilePhoto});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'];
    countryCode = json['countryCode'];
    addressName = json['addressName']??"";
    mobileNumber = json['mobileNumber'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['name'] = name;
    data['countryCode'] = countryCode;
    data['mobileNumber'] = mobileNumber;
    data['profilePhoto'] = profilePhoto;
    return data;
  }
}
