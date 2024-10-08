import 'package:equatable/equatable.dart';

class SetPasswordParams extends Equatable {
  String firstPass;
  String secPass;
  int mobileUserId;
  String resetCode;

  SetPasswordParams(
      this.firstPass, this.secPass, this.mobileUserId, this.resetCode);

  factory SetPasswordParams.empty() {
    return SetPasswordParams('', '', 0, '');
  }

  setFirstPass(String first) {
    firstPass = first;
  }

  setSecondPass(String second) {
    secPass = second;
  }
  setResetCodeAndId(String resetCode, int mobileUserId) {
    this.resetCode = resetCode;
    this.mobileUserId = mobileUserId;
  }

  SetPasswordParams copyWith({String? p, String? o}) {
    return SetPasswordParams(
        p ?? firstPass, o ?? secPass, mobileUserId, resetCode);
  }

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
        "resetCode": resetCode,
        'password': firstPass
      };

  @override
  List<Object?> get props => [firstPass, secPass];
}
