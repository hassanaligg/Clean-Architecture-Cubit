class RegularExpressionsHelper {
  static RegExp lengthReg = RegExp(r'^.{8,}');
  static RegExp upperCaseReg = RegExp(r'^(?=.*?[A-Z])');
  static RegExp lowerCaseReg = RegExp(r'^(?=.*?[a-z])');
  static RegExp justNumberReg = RegExp(r'^[0-9]+$');
  static RegExp numberReg = RegExp(r'^(?=.*?[0-9])');
  static RegExp specialCharacterReg = RegExp(r'^(?=.*?[!@#\$&*~])');
  // static RegExp phoneNumberReg = RegExp(r'(^(?:[+0]9)?[0-9]{13,14}$)');
  static RegExp phoneNumberReg = RegExp(r'^(?:[+00]9)?[0-9]{9}$');
  static RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp guidReg = RegExp(r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$');
}
