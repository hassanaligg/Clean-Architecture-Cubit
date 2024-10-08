import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/password_field_failure.dart';

class PasswordFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required PasswordFieldFailure failure, }) {

    switch (failure.error) {
      case PasswordError.empty:
        return tr("failures.password.empty");
      case PasswordError.lengthError:
        return tr("failures.password.length");
      case PasswordError.oneNumber:
        return tr("failures.password.number");
      case PasswordError.oneSpecialCharacter:
        return tr("failures.password.special_character");
      case PasswordError.oneUpperCase:
        return tr("failures.password.upper_case");
      case PasswordError.oneLowerCase:
        return tr("failures.password.lower_case");
    }
  }
}
