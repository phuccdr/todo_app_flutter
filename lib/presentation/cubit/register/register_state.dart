import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';

@injectable
class RegisterState extends Equatable {
  final NameValidator nameValidator;
  final PasswordValidator passwordValidator;
  final ConfirmPasswordValidator confirmPasswordValidator;
  final bool isValid;
  final FormzSubmissionStatus status;

  RegisterState copyWith({
    NameValidator? nameValidator,
    PasswordValidator? passwordValidator,
    ConfirmPasswordValidator? confirmPasswordValidator,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return RegisterState(
      nameValidator: nameValidator ?? this.nameValidator,
      passwordValidator: passwordValidator ?? this.passwordValidator,
      confirmPasswordValidator:
          confirmPasswordValidator ?? this.confirmPasswordValidator,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  const RegisterState({
    this.nameValidator = const NameValidator.pure(),
    this.passwordValidator = const PasswordValidator.pure(),
    this.confirmPasswordValidator = const ConfirmPasswordValidator.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
    nameValidator,
    passwordValidator,
    confirmPasswordValidator,
    isValid,
    status,
  ];
}
