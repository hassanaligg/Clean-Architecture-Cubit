import 'package:dawaa24/core/utils/failures/field_failure/confirm_password_field_failure.dart';
import 'package:easy_localization/easy_localization.dart';



class ConfirmPasswordFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required ConfirmPasswordFieldFailure failure, }) {

    switch (failure.error) {
      case ConfirmPasswordFieldError.empty:
        return tr("failures.confirm_password.empty");
      case ConfirmPasswordFieldError.passwordDoNotMatch:
        return tr("failures.confirm_password.don't_match");
    }
  }
}
