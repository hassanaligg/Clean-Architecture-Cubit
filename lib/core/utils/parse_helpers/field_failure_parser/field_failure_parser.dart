import 'package:dawaa24/core/utils/failures/field_failure/confirm_password_field_failure.dart';
import 'package:dawaa24/core/utils/failures/field_failure/required_field_failure.dart';
import 'package:dawaa24/core/utils/failures/field_failure/wrong_qr_failure.dart';
import 'package:dawaa24/core/utils/parse_helpers/field_failure_parser/confirm_password_field_parser.dart';
import 'package:dawaa24/core/utils/parse_helpers/field_failure_parser/password_field_failure_parser.dart';
import 'package:dawaa24/core/utils/parse_helpers/field_failure_parser/phone_number_field_parser.dart';
import 'package:dawaa24/core/utils/parse_helpers/field_failure_parser/wrong_qr_parser.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/email_faild_failure.dart';
import '../../failures/field_failure/field_failure.dart';
import '../../failures/field_failure/greater_date_failure.dart';
import '../../failures/field_failure/otp_field_failure.dart';
import '../../failures/field_failure/password_field_failure.dart';
import '../../failures/field_failure/phone_number_field_failure.dart';
import '../../failures/field_failure/required_field_number_failure.dart';
import 'email_field_parser.dart';
import 'greater_date_failure_parser.dart';
import 'number_field_parser.dart';
import 'otp_field_failurere_parser.dart';

class FieldFailureParser {
  static String mapFieldFailureToErrorMessage({
    required FieldFailure failure,
  }) {
    if (failure is PhoneNumberFieldFailure) {
      return PhoneNumberFieldFailureParser.mapFieldFailureToErrorMessage(
        failure: failure,
      );
    } else if (failure is OtpFieldFailure) {
      return OtpFieldFailureParser.mapFieldFailureToErrorMessage(
        failure: failure,
      );
    } else if (failure is EmailFieldFailure) {
      return EmailFieldFailureParser.mapFieldFailureToErrorMessage(
        failure: failure,
      );
    } else if (failure is PasswordFieldFailure) {
      return PasswordFieldFailureParser.mapFieldFailureToErrorMessage(
        failure: failure,
      );
    } else if (failure is ConfirmPasswordFieldFailure) {
      return ConfirmPasswordFieldFailureParser.mapFieldFailureToErrorMessage(
          failure: failure);
    } else if (failure is RequiredFieldFailure) {
      if (failure.error == RequiredFieldError.empty) {
        return "failures.required".tr();
      } else {
        return "failures.between3and50".tr();
      }
    } else if (failure is NumberFieldFailure) {
      return NumberFieldFailureParser.mapFieldFailureToErrorMessage(
          failure: failure);
    } else if (failure is GreaterDateFailure) {
      return GreaterDateFailureParser.mapFieldFailureToErrorMessage(
          failure: failure);
    } else if (failure is WrongQRFailure) {
      return WrongQRFailureParser.mapFieldFailureToErrorMessage(
          failure: failure);
    } else {
      return "Invalid Info";
    }
  }
}
