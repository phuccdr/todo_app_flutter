import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';
import 'package:todoapp/presentation/cubit/login/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  void onUserNameChange(String value) {
    final nameValidator = NameValidator.dirty(value);
    emit(
      state.copyWith(
        nameValidator: nameValidator,
        isValid: Formz.validate([nameValidator, state.passwordValidator]),
      ),
    );
  }

  void onPasswordChange(String value) {
    final passwordValidator = PasswordValidator.dirty(value);
    emit(
      state.copyWith(
        passwordValidator: passwordValidator,
        isValid: Formz.validate([state.nameValidator, passwordValidator]),
      ),
    );
  }

  Future onLogin() async {}
}
