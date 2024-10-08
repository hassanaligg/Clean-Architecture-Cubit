import 'package:dawaa24/core/utils/failures/field_failure/required_field_number_failure.dart';
import 'package:easy_localization/easy_localization.dart';


class NumberFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required NumberFieldFailure failure,}) {
    switch (failure.error) {
      case NumberFieldError.empty:
        return tr("failures.required");
      case NumberFieldError.notValid:
        return "Number Invalid";
    }
  }
}
