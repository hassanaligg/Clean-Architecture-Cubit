


import 'field_failure.dart';

enum PasswordError {
  oneUpperCase,
  oneLowerCase,
  oneSpecialCharacter,
  oneNumber,
  lengthError,
  empty,

}



class PasswordFieldFailure extends FieldFailure{
  PasswordError error;

  PasswordFieldFailure(this.error);
}