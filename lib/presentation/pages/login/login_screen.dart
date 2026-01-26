import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/core/utils/validator/name_validator.dart';
import 'package:todoapp/core/utils/validator/password_validator.dart';
import 'package:todoapp/presentation/cubit/login/login_cubit.dart';
import 'package:todoapp/presentation/cubit/login/login_state.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';
import 'package:todoapp/presentation/widget/textfield/password_text_input.dart';
import 'package:todoapp/presentation/widget/textfield/user_name_text_input.dart';
import 'package:todoapp/presentation/widget/textspan/two_text_span.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginState()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status == FormzSubmissionStatus.success) {
        } else if (state.status.isInProgress) {
          _showLoading();
        } else if (state.status == FormzSubmissionStatus.failure) {
          _showLoginFaild();
        } else if (state.status == FormzSubmissionStatus.success) {}
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 56),
                const Text('Login', style: AppTextStyle.titleLarge),
                const SizedBox(height: 52),
                _buildUserNameTextField(),
                const SizedBox(height: 24),
                _buildPasswordTextField(),
                const SizedBox(height: 68),
                _buildButtonSubmit(),
                const Spacer(),
                TwoTextSpan(
                  firstText: "Don't have an account?",
                  secondText: " Register",
                  onSecondTextClick: () {
                    onRegisterClick();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return BlocSelector<LoginCubit, LoginState, PasswordValidator>(
      selector: (LoginState state) {
        return state.passwordValidator;
      },
      builder: (context, state) {
        return PasswordTextInput(
          onChanged: (value) {
            context.read<LoginCubit>().onPasswordChange(value);
          },
          isValid: state.isValid,
          title: 'Password',
        );
      },
    );
  }

  Widget _buildUserNameTextField() {
    return BlocSelector<LoginCubit, LoginState, NameValidator>(
      selector: (LoginState state) {
        return state.nameValidator;
      },
      builder: (context, state) {
        return UserNameTextInput(
          onChanged: (value) {
            context.read<LoginCubit>().onUserNameChange(value);
          },
          isValid: state.isValid,
        );
      },
    );
  }

  void onRegisterClick() {}

  Widget _buildButtonSubmit() {
    return BlocSelector<LoginCubit, LoginState, bool>(
      builder: (context, state) {
        return ButtonSubmit(
          text: 'Login',
          onSubmit: state
              ? () {
                  context.read<LoginCubit>().onLogin();
                }
              : null,
        );
      },
      selector: (LoginState state) {
        return state.isValid;
      },
    );
  }

  void _showLoading() {}

  void _showLoginFaild() {}
}
