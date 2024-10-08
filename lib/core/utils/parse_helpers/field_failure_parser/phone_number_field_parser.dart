import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/phone_number_field_failure.dart';

class PhoneNumberFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required PhoneNumberFieldFailure failure,}) {
    switch (failure.error) {
      case PhoneNumberError.empty:
        return tr("failures.phone.empty");
      case PhoneNumberError.notValid:
        return tr("failures.phone.not_valid");
    }
  }
}
