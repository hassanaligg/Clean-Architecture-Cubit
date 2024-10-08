

import 'field_failure.dart';


enum NumberFieldError {
  empty,
  notValid,
}

class NumberFieldFailure extends FieldFailure{
NumberFieldError error;

NumberFieldFailure(this.error);


}