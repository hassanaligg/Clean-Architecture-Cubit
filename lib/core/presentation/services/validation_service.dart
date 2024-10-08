import 'package:dawaa24/core/utils/failures/field_failure/wrong_qr_failure.dart';

import '../../utils/failures/field_failure/confirm_password_field_failure.dart';
import '../../utils/failures/field_failure/email_faild_failure.dart';
import '../../utils/failures/field_failure/greater_date_failure.dart';
import '../../utils/failures/field_failure/otp_field_failure.dart';
import '../../utils/failures/field_failure/password_field_failure.dart';
import '../../utils/failures/field_failure/phone_number_field_failure.dart';
import '../../utils/failures/field_failure/required_field_failure.dart';
import '../../utils/failures/field_failure/required_field_number_failure.dart';
import '../regular_expression_helper.dart';

abstract class ValidationService {
  static RequiredFieldFailure? requiredFieldValidator(String value) {
    value = value.trim();
    return value.isNotEmpty == true
        ? null
        : RequiredFieldFailure(RequiredFieldError.empty);
  }

  static NumberFieldFailure? numberFieldValidator(String value) {
    if (value.isEmpty) {
      return NumberFieldFailure(NumberFieldError.empty);
    }
    if (!RegularExpressionsHelper.justNumberReg.hasMatch(value)) {
      return NumberFieldFailure(NumberFieldError.notValid);
    }
    return null;
  }

  static PhoneNumberFieldFailure? phoneNumberFieldValidator(String value) {
    if (value.isEmpty) {
      return PhoneNumberFieldFailure(PhoneNumberError.empty);
    }
    if (!RegularExpressionsHelper.phoneNumberReg.hasMatch(value)) {
      return PhoneNumberFieldFailure(PhoneNumberError.notValid);
    }
    return null;
  }

  static RequiredFieldFailure? requiredFullNameFieldValidator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return RequiredFieldFailure(RequiredFieldError.empty);
    }
    return (value.length >= 3 && value.length <= 50) == true
        ? null
        : RequiredFieldFailure(RequiredFieldError.nd3_50);
  }

  static PasswordFieldFailure? passwordFieldvalidator(String value) {
    if (value.isEmpty) {
      return PasswordFieldFailure(PasswordError.empty);
    }
    if (!RegularExpressionsHelper.lengthReg.hasMatch(value)) {
      return PasswordFieldFailure(PasswordError.lengthError);
    }
    if (!RegularExpressionsHelper.upperCaseReg.hasMatch(value)) {
      return PasswordFieldFailure(PasswordError.oneUpperCase);
    }
    if (!RegularExpressionsHelper.lowerCaseReg.hasMatch(value)) {
      return PasswordFieldFailure(PasswordError.oneLowerCase);
    }
    if (!RegularExpressionsHelper.specialCharacterReg.hasMatch(value)) {
      return PasswordFieldFailure(PasswordError.oneSpecialCharacter);
    }
    if (!RegularExpressionsHelper.numberReg.hasMatch(value)) {
      return PasswordFieldFailure(PasswordError.oneNumber);
    }

    return null;
  }

  static OtpFieldFailure? otpFieldvalidator(String value) {
    return value.isEmpty
        ? OtpFieldFailure(OtpFieldError.empty)
        : value.length < 4
            ? OtpFieldFailure(OtpFieldError.otpLessThanNumber)
            : null;
  }

  static EmailFieldFailure? emailFieldvalidator(String value) {
    if (value.isEmpty) {
      return EmailFieldFailure(EmailError.empty);
    }
    if (!RegularExpressionsHelper.emailReg.hasMatch(value)) {
      return EmailFieldFailure(EmailError.notValid);
    }
    return null;
  }

  static ConfirmPasswordFieldFailure? confirmPasswordFieldvalidator(
      String value, String originPassword) {
    return value.isNotEmpty == true
        ? value == originPassword
            ? null
            : ConfirmPasswordFieldFailure(
                ConfirmPasswordFieldError.passwordDoNotMatch)
        : ConfirmPasswordFieldFailure(ConfirmPasswordFieldError.empty);
  }

  static GreaterDateFailure? greaterDateFieldValidator(
      DateTime? value, DateTime? startDate) {
    return value == null
        ? GreaterDateFailure(GreaterDateError.empty)
        : startDate == null
            ? null
            : value.compareTo(startDate) < 0
                ? GreaterDateFailure(GreaterDateError.notValid)
                : null;
  }

  static WrongQRFailure? wrongQRValidator(String value) {
    if (value.isEmpty) {
      return WrongQRFailure(WrongQRError.empty);
    }
    if (!RegularExpressionsHelper.guidReg.hasMatch(value)) {
      return WrongQRFailure(WrongQRError.notValid);
    }
    return null;
  }
}
