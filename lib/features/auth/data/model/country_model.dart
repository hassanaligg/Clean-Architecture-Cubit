class CountryModel {
  String? name;
  String? code;
  String? isoCode2;
  String? flag;
  int? id;

  CountryModel({this.name, this.code, this.isoCode2, this.flag, this.id});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    isoCode2 = json['isoCode2'];
    flag = getFlagEmoji(json['isoCode2']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['isoCode2'] = isoCode2;
    data['flag'] = flag;
    data['id'] = id;
    return data;
  }
  static String getFlagEmoji(String countryCode) {
    List<int> codePoints = countryCode
        .toUpperCase()
        .split('')
        .map((char) => 127397 + char.codeUnitAt(0))
        .toList();
    return String.fromCharCodes(codePoints);
  }
}
