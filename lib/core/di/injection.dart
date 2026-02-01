import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/core/database/app_database.dart';
import 'package:todoapp/core/di/injection.config.dart';
import 'package:todoapp/core/network/dio_client.dart';

final GetIt getIt = GetIt.instance;
@InjectableInit()
Future<void> configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => createDio();

  @lazySingleton
  AppDatabase get database => AppDatabase();

  //SharedPreferences() là bất đồng bộ
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
