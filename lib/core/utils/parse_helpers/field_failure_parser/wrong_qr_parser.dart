import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/wrong_qr_failure.dart';

class WrongQRFailureParser {
  static String mapFieldFailureToErrorMessage({
    required WrongQRFailure failure,
  }) {
    switch (failure.error) {
      case WrongQRError.empty:
        return tr("failures.qr.empty");
      case WrongQRError.notValid:
        return tr("failures.qr.less_than");
    }
  }
}
