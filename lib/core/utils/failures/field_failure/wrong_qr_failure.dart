import 'field_failure.dart';

enum WrongQRError {
  empty,
  notValid,
}

class WrongQRFailure extends FieldFailure {
  WrongQRError error;

  WrongQRFailure(this.error);
}
