import 'package:formz/formz.dart';

enum NameValidationError { invalid, empty, valid }

class NameValidator extends FormzInput<String, NameValidationError> {
  const NameValidator.pure() : super.pure('');
  const NameValidator.dirty([super.value = '']) : super.dirty();
  @override
  NameValidationError? validator(String value) {
    if (value == '' || value.isEmpty) {
      return NameValidationError.empty;
    } else {
      return value.length >= 2 ? null : NameValidationError.invalid;
    }
  }
}
