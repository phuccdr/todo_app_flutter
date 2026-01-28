import 'package:injectable/injectable.dart';
import 'package:todoapp/data/datasource/local/dao/category/category_dao.dart';
import 'package:todoapp/data/models/category_model.dart';

@LazySingleton()
class CategoryLocalDatasource {
  final CategoryDao _categoryDao;
  CategoryLocalDatasource(this._categoryDao);
  Future<List<CategoryModel>> getCategories() async {
    final resultCategories = await _categoryDao.getAllCategories();
    return resultCategories.map((c) => CategoryModel.fromDrift(c)).toList();
  }

  Future<void> upsertCategory(CategoryModel categoryModel) async {
    await _categoryDao.upsertCategory(categoryModel.toDriftCompanion());
  }

  Future<void> insertCategories(List<CategoryModel> categories) async {
    final companions = categories.map((c) => c.toDriftCompanion()).toList();
    await _categoryDao.upsertCategories(companions);
  }

  Stream<List<CategoryModel>> watchCategories() {
    return _categoryDao.watchCategories().map(
      (driftCategories) =>
          driftCategories.map((c) => CategoryModel.fromDrift(c)).toList(),
    );
  }
}
