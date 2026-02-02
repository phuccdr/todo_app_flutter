import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/category.dart';

abstract class CategoryRepository {
  TaskEither<Failure, void> fetchCategoriesFromServer();
  Stream<Either<Failure, List<Category>>> watchCategories();
  TaskEither<Failure, Category?> getCategoryById(String categoryId);
}
