import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/user_model.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<UserModel> login(String email, String password) async {
    final response = await _dio.get('/login');
    return UserModel.fromJson(response.data);
  }

  Future<bool> register(String email, String pasword) async {
    final response = await _dio.post('/register');
    return jsonDecode(response.data)['status'] as bool;
  }
}
