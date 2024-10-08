import 'package:equatable/equatable.dart';

class VerifyOtpCodeParams extends Equatable  {
  String phoneNumber;
  int otpNumber;

  VerifyOtpCodeParams(this.phoneNumber, this.otpNumber);

  factory VerifyOtpCodeParams.empty() {
    return VerifyOtpCodeParams('',0);
  }

  VerifyOtpCodeParams copyWith({String? p, int? o }) {
    return VerifyOtpCodeParams(
   p??phoneNumber,
      o??otpNumber
    );
  }

  Map<String, dynamic> toJson()=> {
   'mobileNumber': phoneNumber,
   'otpCode' : otpNumber.toString()
  };

  @override
  List<Object?> get props => [phoneNumber, otpNumber];


}
