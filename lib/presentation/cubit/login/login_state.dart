import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';

@injectable
class LoginState extends Equatable {
  final NameValidator nameValidator;
  final PasswordValidator passwordValidator;
  final bool isValid;
  final FormzSubmissionStatus status;

  const LoginState({
    this.nameValidator = const NameValidator.pure(),
    this.passwordValidator = const PasswordValidator.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
    nameValidator,
    passwordValidator,
    status,
    isValid,
  ];

  LoginState copyWith({
    NameValidator? nameValidator,
    PasswordValidator? passwordValidator,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      nameValidator: nameValidator ?? this.nameValidator,
      passwordValidator: passwordValidator ?? this.passwordValidator,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
