import 'package:dawaa24/core/utils/failures/failures.dart';

import '../base_failure.dart';

abstract class HttpFailure extends Failure {
  const HttpFailure();
}

class ServerFailure extends HttpFailure {
  const ServerFailure();
}

class CustomFailure extends HttpFailure {
  final String message;

  const CustomFailure({required this.message});
}

class UnauthorizedFailure extends HttpFailure {
  const UnauthorizedFailure();
}

class NoInternetFailure extends HttpFailure {
  const NoInternetFailure();
}

class TimeOutFailure extends HttpFailure {
  const TimeOutFailure();
}

class NotVerifiedFailure extends HttpFailure {
  const NotVerifiedFailure();
}
class CancelRequestFailure extends HttpFailure {
  const CancelRequestFailure();
}
class UnknownFailure extends HttpFailure {
  const UnknownFailure();
}

class UnexpectedResponseFailure  extends HttpFailure{
  const  UnexpectedResponseFailure();
}


class BadRequestFailure extends HttpFailure {
  const BadRequestFailure(this.message);
  final String message;
}

