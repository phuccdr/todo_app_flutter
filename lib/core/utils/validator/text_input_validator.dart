import 'package:formz/formz.dart';

enum TextInputValidationError { invalid, empty, valid }

class TextInputValidator extends FormzInput<String, TextInputValidationError> {
  const TextInputValidator.pure() : super.pure('');
  const TextInputValidator.dirty([super.value = '']) : super.dirty();
  @override
  TextInputValidationError? validator(String value) {
    if (value == '' || value.isEmpty) {
      return TextInputValidationError.empty;
    } else {
      return value.isNotEmpty ? null : TextInputValidationError.invalid;
    }
  }
}
