import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';
import 'package:todoapp/domain/usecase/check_loggedin_usecase.dart';
import 'package:todoapp/domain/usecase/login_usecase.dart';
import 'package:todoapp/presentation/cubit/login/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  final CheckLoggedinUsecase _checkLoggedinUsecase;
  LoginCubit(
    super.initialState,
    this._loginUsecase,
    this._checkLoggedinUsecase,
  );

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

  Future onLogin() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _loginUsecase.excute(
      state.nameValidator.value,
      state.passwordValidator.value,
    );
    result.fold(
      (e) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
      (_) => state.copyWith(status: FormzSubmissionStatus.success),
    );
  }
}
