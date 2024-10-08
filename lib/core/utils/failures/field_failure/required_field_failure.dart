import 'field_failure.dart';

enum RequiredFieldError {
  empty,
  nd3_50,
}

class RequiredFieldFailure extends FieldFailure {
  RequiredFieldError error;

  RequiredFieldFailure(this.error);
}
