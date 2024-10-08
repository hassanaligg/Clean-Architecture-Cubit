import '../../domain/entities/forgot_password_entity.dart';

class ForgetPasswordModel {
  int? mobileUserId;
  String? resetCode;

  ForgetPasswordModel({this.mobileUserId, this.resetCode});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    mobileUserId = json['mobileUserId'];
    resetCode = json['resetCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileUserId'] = mobileUserId;
    data['resetCode'] = resetCode;
    return data;
  }

  @override
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(mobileUserId: mobileUserId, resetCode: resetCode);
  }
}
