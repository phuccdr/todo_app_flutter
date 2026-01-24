import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/cubit/register/register_cubit.dart';
import 'package:todoapp/presentation/cubit/register/register_state.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';
import 'package:todoapp/presentation/widget/textfield/password_text_input.dart';
import 'package:todoapp/presentation/widget/textfield/user_name_text_input.dart';
import 'package:todoapp/presentation/widget/textspan/two_text_span.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          _onRegisterSuccess(context);
        } else if (state.status.isInProgress) {
          _showLoading();
        } else if (state.status == FormzSubmissionStatus.failure) {
          _showRegisterFailed();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text('Register', style: AppTextStyle.titleLarge),
                const SizedBox(height: 52),
                _buildUserNameTextField(),
                const SizedBox(height: 24),
                _buildPasswordTextField(),
                const SizedBox(height: 24),
                _buildConfirmPasswordTextField(),
                const SizedBox(height: 40),
                _buildButtonSubmit(),
                const Spacer(),
                TwoTextSpan(
                  firstText: "Already have an account?",
                  secondText: " Login",
                  onSecondTextClick: () {
                    _onLoginClick(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameTextField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.nameValidator != current.nameValidator,
      builder: (context, state) {
        return UserNameTextInput(
          onChanged: (value) {
            context.read<RegisterCubit>().onUserNameChange(value);
          },
          isValid: state.nameValidator.isValid,
        );
      },
    );
  }

  Widget _buildPasswordTextField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.passwordValidator != current.passwordValidator,
      builder: (context, state) {
        return PasswordTextInput(
          onChanged: (value) {
            context.read<RegisterCubit>().onPasswordChange(value);
          },
          isValid: state.passwordValidator.isValid,
          title: 'Password',
        );
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.confirmPasswordValidator != current.confirmPasswordValidator,
      builder: (context, state) {
        return PasswordTextInput(
          onChanged: (value) {
            context.read<RegisterCubit>().onconfirmPasswordChange(value);
          },
          isValid: state.confirmPasswordValidator.isValid,
          title: 'Confirm Password',
        );
      },
    );
  }

  Widget _buildButtonSubmit() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return ButtonSubmit(
          text: 'Register',
          onSubmit: state.isValid
              ? () {
                  _onRegisterSubmit(context);
                }
              : null,
        );
      },
    );
  }

  void _onRegisterSubmit(BuildContext context) {
    // TODO: Implement register logic
  }

  void _onLoginClick(BuildContext context) {
    context.pop();
  }

  void _onRegisterSuccess(BuildContext context) {
    // TODO: Navigate to home or login screen
  }

  void _showLoading() {
    // TODO: Show loading indicator
  }

  void _showRegisterFailed() {
    // TODO: Show error message
  }
}
