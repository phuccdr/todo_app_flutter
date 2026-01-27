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
import 'package:todoapp/core/database/app_database.dart' as _i850;
import 'package:todoapp/core/di/injection.dart' as _i344;
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart'
    as _i18;
import 'package:todoapp/core/utils/validator/name_validator.dart' as _i703;
import 'package:todoapp/core/utils/validator/password_validator.dart' as _i488;
import 'package:todoapp/data/datasource/local/dao/category_dao.dart' as _i716;
import 'package:todoapp/data/datasource/local/local_data_source/category_local_datasource.dart'
    as _i812;
import 'package:todoapp/data/datasource/remote/category_remote_datasource.dart'
    as _i955;
import 'package:todoapp/data/repositories/category_repo/category_repository_impl.dart'
    as _i788;
import 'package:todoapp/domain/entities/task.dart' as _i1017;
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart'
    as _i872;
import 'package:todoapp/domain/usecase/get_categories_usecase.dart' as _i839;
import 'package:todoapp/presentation/cubit/dialog/category_cubit.dart' as _i895;
import 'package:todoapp/presentation/cubit/login/login_cubit.dart' as _i709;
import 'package:todoapp/presentation/cubit/login/login_state.dart' as _i637;
import 'package:todoapp/presentation/cubit/register/register_cubit.dart'
    as _i742;
import 'package:todoapp/presentation/cubit/register/register_state.dart'
    as _i614;
import 'package:todoapp/presentation/cubit/task/add_task/add_task_cubit.dart'
    as _i284;
import 'package:todoapp/presentation/cubit/task/task_list/task_list_cubit.dart'
    as _i376;
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart'
    as _i46;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i742.RegisterCubit>(() => _i742.RegisterCubit());
    gh.factory<_i284.AddTaskCubit>(() => _i284.AddTaskCubit());
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i850.AppDatabase>(() => appModule.database);
    gh.factory<_i614.RegisterState>(
      () => _i614.RegisterState(
        nameValidator: gh<_i703.NameValidator>(),
        passwordValidator: gh<_i488.PasswordValidator>(),
        confirmPasswordValidator: gh<_i18.ConfirmPasswordValidator>(),
        isValid: gh<bool>(),
        status: gh<_i739.FormzSubmissionStatus>(),
      ),
    );
    gh.factory<_i46.TaskListState>(
      () => _i46.TaskListState(
        tasks: gh<List<_i1017.Task>>(),
        status: gh<_i46.TaskListStatus>(),
        errorMessage: gh<String>(),
      ),
    );
    gh.lazySingleton<_i716.CategoryDao>(
      () => appModule.categoryDao(gh<_i850.AppDatabase>()),
    );
    gh.factory<_i376.TaskListCubit>(
      () => _i376.TaskListCubit(gh<_i46.TaskListState>()),
    );
    gh.lazySingleton<_i955.CategoryRemoteDatasource>(
      () => _i955.CategoryRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i812.CategoryLocalDatasource>(
      () => _i812.CategoryLocalDatasource(gh<_i716.CategoryDao>()),
    );
    gh.lazySingleton<_i872.CategoryRepository>(
      () => _i788.CategoryRepositoryImpl(
        gh<_i955.CategoryRemoteDatasource>(),
        gh<_i812.CategoryLocalDatasource>(),
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
    gh.factory<_i839.GetCategoriesUseCase>(
      () => _i839.GetCategoriesUseCase(gh<_i872.CategoryRepository>()),
    );
    gh.factory<_i895.CategoryCubit>(
      () => _i895.CategoryCubit(gh<_i839.GetCategoriesUseCase>()),
    );
    gh.factory<_i709.LoginCubit>(
      () => _i709.LoginCubit(gh<_i637.LoginState>()),
    );
    return this;
  }
}

class _$AppModule extends _i344.AppModule {}
