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
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:todoapp/core/database/app_database.dart' as _i850;
import 'package:todoapp/core/di/injection.dart' as _i344;
import 'package:todoapp/core/utils/validator/confirm_password_validator.dart'
    as _i18;
import 'package:todoapp/core/utils/validator/name_validator.dart' as _i703;
import 'package:todoapp/core/utils/validator/password_validator.dart' as _i488;
import 'package:todoapp/data/datasource/local/dao/category/category_dao.dart'
    as _i107;
import 'package:todoapp/data/datasource/local/dao/task/task_dao.dart' as _i782;
import 'package:todoapp/data/datasource/local/local_data_source/category_local_datasource.dart'
    as _i812;
import 'package:todoapp/data/datasource/local/local_data_source/task_local_datasource.dart'
    as _i1023;
import 'package:todoapp/data/datasource/local/share_pref/prefs.dart' as _i126;
import 'package:todoapp/data/datasource/remote/auth_remote_datasource.dart'
    as _i411;
import 'package:todoapp/data/datasource/remote/category_remote_datasource.dart'
    as _i955;
import 'package:todoapp/data/datasource/remote/task_remote_datasource.dart'
    as _i290;
import 'package:todoapp/data/repositories/auth_repo/auth_repository_impl.dart'
    as _i934;
import 'package:todoapp/data/repositories/category_repo/category_repository_impl.dart'
    as _i788;
import 'package:todoapp/data/repositories/task_repo/task_repository_impl.dart'
    as _i387;
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart'
    as _i7;
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart'
    as _i872;
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart'
    as _i560;
import 'package:todoapp/domain/usecase/delete_task_usecase.dart' as _i619;
import 'package:todoapp/domain/usecase/fetch_categories_usecase.dart' as _i369;
import 'package:todoapp/domain/usecase/fetch_tasks_usecase.dart' as _i504;
import 'package:todoapp/domain/usecase/get_category_by_id_usecase.dart'
    as _i261;
import 'package:todoapp/domain/usecase/get_task_by_id_usecase.dart' as _i233;
import 'package:todoapp/domain/usecase/get_user_usecase.dart' as _i319;
import 'package:todoapp/domain/usecase/insert_task_usecase.dart' as _i367;
import 'package:todoapp/domain/usecase/login_usecase.dart' as _i209;
import 'package:todoapp/domain/usecase/register_usecase.dart' as _i435;
import 'package:todoapp/domain/usecase/update_task_usecase.dart' as _i421;
import 'package:todoapp/domain/usecase/watch_categories_usecase.dart' as _i45;
import 'package:todoapp/domain/usecase/watch_task_usecase.dart' as _i932;
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart' as _i602;
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
import 'package:todoapp/presentation/model/task_display.dart' as _i615;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i850.AppDatabase>(() => appModule.database);
    gh.lazySingleton<_i955.CategoryRemoteDatasource>(
      () => _i955.CategoryRemoteDatasource(),
    );
    gh.factory<_i614.RegisterState>(
      () => _i614.RegisterState(
        nameValidator: gh<_i703.NameValidator>(),
        passwordValidator: gh<_i488.PasswordValidator>(),
        confirmPasswordValidator: gh<_i18.ConfirmPasswordValidator>(),
        isValid: gh<bool>(),
        status: gh<_i739.FormzSubmissionStatus>(),
      ),
    );
    gh.lazySingleton<_i107.CategoryDao>(
      () => _i107.CategoryDao(gh<_i850.AppDatabase>()),
    );
    gh.lazySingleton<_i782.TaskDao>(
      () => _i782.TaskDao(gh<_i850.AppDatabase>()),
    );
    gh.lazySingleton<_i411.AuthRemoteDataSource>(
      () => _i411.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i290.TaskRemoteDatasource>(
      () => _i290.TaskRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i812.CategoryLocalDatasource>(
      () => _i812.CategoryLocalDatasource(gh<_i107.CategoryDao>()),
    );
    gh.lazySingleton<_i126.Prefs>(
      () => _i126.Prefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i872.CategoryRepository>(
      () => _i788.CategoryRepositoryImpl(
        gh<_i955.CategoryRemoteDatasource>(),
        gh<_i812.CategoryLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i7.AuthRepository>(
      () => _i934.AuthRepositoryImpl(
        gh<_i126.Prefs>(),
        gh<_i411.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i46.TaskListState>(
      () => _i46.TaskListState(
        tasks: gh<List<_i615.TaskDisplay>>(),
        status: gh<_i46.TaskListStatus>(),
        errorMessage: gh<String>(),
        searchQuery: gh<String>(),
      ),
    );
    gh.lazySingleton<_i1023.TaskLocalDatasource>(
      () => _i1023.TaskLocalDatasource(gh<_i782.TaskDao>()),
    );
    gh.factory<_i637.LoginState>(
      () => _i637.LoginState(
        nameValidator: gh<_i703.NameValidator>(),
        passwordValidator: gh<_i488.PasswordValidator>(),
        isValid: gh<bool>(),
        status: gh<_i739.FormzSubmissionStatus>(),
      ),
    );
    gh.factory<_i369.FetchCategoriesUseCase>(
      () => _i369.FetchCategoriesUseCase(gh<_i872.CategoryRepository>()),
    );
    gh.factory<_i261.GetCategoryByIdUsecase>(
      () => _i261.GetCategoryByIdUsecase(gh<_i872.CategoryRepository>()),
    );
    gh.factory<_i45.WatchCategoriesUsecase>(
      () => _i45.WatchCategoriesUsecase(gh<_i872.CategoryRepository>()),
    );
    gh.lazySingleton<_i560.TaskRepository>(
      () => _i387.TaskRepositoryImpl(
        gh<_i1023.TaskLocalDatasource>(),
        gh<_i290.TaskRemoteDatasource>(),
      ),
    );
    gh.factory<_i319.GetUserUsecase>(
      () => _i319.GetUserUsecase(gh<_i7.AuthRepository>()),
    );
    gh.factory<_i209.LoginUsecase>(
      () => _i209.LoginUsecase(gh<_i7.AuthRepository>()),
    );
    gh.factory<_i435.RegisterUsecase>(
      () => _i435.RegisterUsecase(gh<_i7.AuthRepository>()),
    );
    gh.factory<_i742.RegisterCubit>(
      () => _i742.RegisterCubit(gh<_i435.RegisterUsecase>()),
    );
    gh.factory<_i504.FetchTasksUsecase>(
      () => _i504.FetchTasksUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i932.WatchTaskUsecase>(
      () => _i932.WatchTaskUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i619.DeleteTaskUsecase>(
      () => _i619.DeleteTaskUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i233.GetTaskByIdUsecase>(
      () => _i233.GetTaskByIdUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i367.InsertTaskUsecase>(
      () => _i367.InsertTaskUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i421.UpdateTaskUsecase>(
      () => _i421.UpdateTaskUsecase(gh<_i560.TaskRepository>()),
    );
    gh.factory<_i895.CategoryCubit>(
      () => _i895.CategoryCubit(
        gh<_i369.FetchCategoriesUseCase>(),
        gh<_i45.WatchCategoriesUsecase>(),
      ),
    );
    gh.factory<_i376.TaskListCubit>(
      () => _i376.TaskListCubit(
        gh<_i504.FetchTasksUsecase>(),
        gh<_i369.FetchCategoriesUseCase>(),
        gh<_i932.WatchTaskUsecase>(),
        gh<_i45.WatchCategoriesUsecase>(),
        gh<_i421.UpdateTaskUsecase>(),
      ),
    );
    gh.factory<_i602.AuthCubit>(
      () => _i602.AuthCubit(gh<_i319.GetUserUsecase>(), gh<String>()),
    );
    gh.factory<_i709.LoginCubit>(
      () => _i709.LoginCubit(gh<_i209.LoginUsecase>()),
    );
    gh.factory<_i284.AddTaskCubit>(
      () => _i284.AddTaskCubit(
        gh<_i367.InsertTaskUsecase>(),
        gh<_i233.GetTaskByIdUsecase>(),
        gh<_i261.GetCategoryByIdUsecase>(),
        gh<_i619.DeleteTaskUsecase>(),
        gh<_i421.UpdateTaskUsecase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i344.AppModule {}
