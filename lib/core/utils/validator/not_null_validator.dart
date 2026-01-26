import 'package:formz/formz.dart';

enum NotNullValidationError { empty }

class NotNullValidator<T> extends FormzInput<T?, NotNullValidationError> {
  const NotNullValidator.pure() : super.pure(null);
  const NotNullValidator.dirty(super.value) : super.dirty();

  @override
  NotNullValidationError? validator(T? value) {
    if (value == null) {
      return NotNullValidationError.empty;
    }
    return null;
  }
}
