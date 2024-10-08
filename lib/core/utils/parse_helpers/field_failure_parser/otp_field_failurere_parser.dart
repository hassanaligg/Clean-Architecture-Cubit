import 'package:easy_localization/easy_localization.dart';

import '../../failures/field_failure/otp_field_failure.dart';

class OtpFieldFailureParser {
  static String mapFieldFailureToErrorMessage(
      {required OtpFieldFailure failure, }) {
    switch (failure.error) {
      case OtpFieldError.empty:
        return tr("failures.otp.empty");
        case OtpFieldError.otpLessThanNumber:
        return tr("failures.otp.less_than");
    }
  }
}
