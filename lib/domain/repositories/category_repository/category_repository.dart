import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/category.dart';

abstract class CategoryRepository {
  Stream<Either<Failure, List<Category>>> getCategories();
  Stream<Either<Failure, List<Category>>> watchCategories();
}
