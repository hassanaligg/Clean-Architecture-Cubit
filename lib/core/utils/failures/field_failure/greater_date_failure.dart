import 'field_failure.dart';

enum GreaterDateError {
  empty,
  notValid,
}

class GreaterDateFailure extends FieldFailure {
  GreaterDateError error;

  GreaterDateFailure(this.error);
}
