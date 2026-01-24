import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';
import 'package:todoapp/presentation/cubit/register/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onUserNameChange(String value) {
    final nameValidator = NameValidator.dirty(value);
    emit(
      state.copyWith(
        nameValidator: nameValidator,
        isValid: Formz.validate([
          nameValidator,
          state.passwordValidator,
          state.confirmPasswordValidator,
        ]),
      ),
    );
  }

  void onPasswordChange(String value) {
    final passwordValidator = PasswordValidator.dirty(value);
    emit(
      state.copyWith(
        passwordValidator: passwordValidator,
        isValid: Formz.validate([
          state.nameValidator,
          passwordValidator,
          state.confirmPasswordValidator,
        ]),
      ),
    );
  }

  void onconfirmPasswordChange(String value) {
    final confirmPasswordValidator = ConfirmPasswordValidator.dirty(
      password: state.passwordValidator.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmPasswordValidator: confirmPasswordValidator,
        isValid: Formz.validate([
          state.nameValidator,
          state.passwordValidator,
          confirmPasswordValidator,
        ]),
      ),
    );
  }
}
