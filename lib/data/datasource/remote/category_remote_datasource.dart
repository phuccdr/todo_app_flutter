import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/category_model.dart';

@LazySingleton()
class CategoryRemoteDatasource {
  static const String _categoryMockPath = 'assets/json/category_mock.json';

  Future<List<CategoryModel>> getCategories() async {
    final String jsonString =
        await rootBundle.loadString(_categoryMockPath);
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
