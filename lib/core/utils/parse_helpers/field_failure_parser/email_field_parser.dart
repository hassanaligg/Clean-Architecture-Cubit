import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/email_faild_failure.dart';

class EmailFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required EmailFieldFailure failure, }) {
    switch (failure.error) {
      case EmailError.empty:
        return tr("failures.email.empty");
      case EmailError.notValid:
        return tr("failures.email.not_valid");
    }
  }
}
