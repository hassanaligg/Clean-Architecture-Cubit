class NationalityModel {
  int? id;
  String? name;

  NationalityModel({this.id, this.name});

  NationalityModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
