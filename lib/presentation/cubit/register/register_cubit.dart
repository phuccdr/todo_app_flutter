import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';
import 'package:todoapp/domain/usecase/register_usecase.dart';
import 'package:todoapp/presentation/cubit/register/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterCubit(this._registerUsecase) : super(const RegisterState());

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

  void onRegister() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final isValid = Formz.validate([
      state.nameValidator,
      state.passwordValidator,
      state.confirmPasswordValidator,
    ]);
    if (!isValid) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure, isValid: isValid),
      );
    }
    final result = await _registerUsecase.excute(
      state.nameValidator.value,
      state.passwordValidator.value,
    );
    result.fold(
      (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      },
      (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      },
    );
  }
}
