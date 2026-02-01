import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/database/app_database.dart';
import 'package:todoapp/data/datasource/local/tables/categories.dart';

part 'category_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<Category?> getCategoryById(String id) {
    return (select(
      categories,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertCategory(CategoriesCompanion category) {
    return into(categories).insertOnConflictUpdate(category);
  }

  Future<void> upsertCategories(List<CategoriesCompanion> categoryList) {
    return batch((batch) {
      batch.insertAllOnConflictUpdate(categories, categoryList);
    });
  }

  Future<int> deleteCategoryById(String id) {
    return (delete(categories)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<Category>> watchCategories() {
    return select(categories).watch();
  }
}
