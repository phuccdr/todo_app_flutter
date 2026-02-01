import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, void>> fetchCategoriesFromServer();
  Stream<Either<Failure, List<Category>>> watchCategories();
  Future<Either<Failure, Category?>> getCategoryById(String categoryId);
}
