import 'package:easy_localization/easy_localization.dart';

import '../../failures/http/http_failure.dart';

class HttpFailureParser {
  static String mapHttpFailureToErrorMessage(
      HttpFailure failure,) {
    if (failure is NoInternetFailure) {
      return tr("failures.no_internet");
    } else if (failure is UnauthorizedFailure) {
      return tr("failures.not_verified");
    } else if (failure is ServerFailure) {
      return tr("failures.server_error");
    } else if (failure is TimeOutFailure) {
    return tr("failures.time_out");
    }
    else if (failure is UnexpectedResponseFailure) {
    return tr("failures.unexpectedResponse");
    } else if (failure is CustomFailure) {
      return failure.message;
    } else {
      return tr("failures.some_thing_wrong");
    }
  }
}
