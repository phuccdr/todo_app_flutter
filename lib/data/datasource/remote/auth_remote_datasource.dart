import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/user_model.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<UserModel> login(String email, String password) async {
    final response = await _dio.get('/login');
    return UserModel.fromJson(response.data[0]);
  }

  Future<void> register(String email, String password) async {
    await _dio.post(
      '/login',
      data: {
        'name': 'phuc',
        'avatar':
            'https://th.bing.com/th/id/R.f3c00fcbb2e23b27e39a0ccbcf290de1?rik=t4EG4qxYKIG5SQ&pid=ImgRaw&r=0',
        'email': email,
        'password': password,
      },
    );
  }
}
