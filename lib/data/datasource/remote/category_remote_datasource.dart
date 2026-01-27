import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/category_model.dart';

@LazySingleton()
class CategoryRemoteDatasource {
  final Dio _dio;
  CategoryRemoteDatasource(this._dio);
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('/categories');
    return (response.data as List)
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
