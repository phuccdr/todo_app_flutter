import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty, valid }

class PasswordValidator extends FormzInput<String, PasswordValidationError> {
  const PasswordValidator.pure() : super.pure(''); // giá trị ban đầu.
  const PasswordValidator.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    if (value == '' || value == null) {
      return PasswordValidationError.empty;
    } else {
      return value.length >= 6 ? null : PasswordValidationError.invalid;
    }
  }
}
