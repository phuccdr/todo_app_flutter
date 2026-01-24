// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:formz/formz.dart' as _i739;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:todoapp/core/di/injection.dart' as _i344;
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart'
    as _i18;
import 'package:todoapp/core/utils/validator/name_validator.dart' as _i703;
import 'package:todoapp/core/utils/validator/password_validator.dart' as _i488;
import 'package:todoapp/presentation/cubit/login/login_cubit.dart' as _i709;
import 'package:todoapp/presentation/cubit/login/login_state.dart' as _i637;
import 'package:todoapp/presentation/cubit/register/register_cubit.dart'
    as _i742;
import 'package:todoapp/presentation/cubit/register/register_state.dart'
    as _i614;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i742.RegisterCubit>(() => _i742.RegisterCubit());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i614.RegisterState>(
      () => _i614.RegisterState(
        nameValidator: gh<_i703.NameValidator>(),
        passwordValidator: gh<_i488.PasswordValidator>(),
        confirmPasswordValidator: gh<_i18.ConfirmPasswordValidator>(),
        isValid: gh<bool>(),
        status: gh<_i739.FormzSubmissionStatus>(),
      ),
    );
    gh.factory<_i637.LoginState>(
      () => _i637.LoginState(
        nameValidator: gh<_i703.NameValidator>(),
        passwordValidator: gh<_i488.PasswordValidator>(),
        isValid: gh<bool>(),
        status: gh<_i739.FormzSubmissionStatus>(),
      ),
    );
    gh.factory<_i709.LoginCubit>(
      () => _i709.LoginCubit(gh<_i637.LoginState>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i344.NetworkModule {}
