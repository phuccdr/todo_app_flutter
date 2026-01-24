import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/constants/constant.dart';
import 'package:todoapp/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;
@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio =>
      Dio(
          BaseOptions(
            baseUrl: Constant.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            request: true,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
        );
}
