import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/greater_date_failure.dart';

class GreaterDateFailureParser {
  static String mapFieldFailureToErrorMessage({
    required GreaterDateFailure failure,
  }) {
    switch (failure.error) {
      case GreaterDateError.empty:
        return tr("failures.grater_date.empty");
      case GreaterDateError.notValid:
        return tr("failures.grater_date.grater_than_error");
    }
  }
}
