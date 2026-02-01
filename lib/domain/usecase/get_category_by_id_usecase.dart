import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart';

@injectable
class GetCategoryByIdUsecase {
  final CategoryRepository _categoryRepo;
  GetCategoryByIdUsecase(this._categoryRepo);

  Future<Either<Failure, Category?>> excute(String categoryId) {
    return _categoryRepo.getCategoryById(categoryId);
  }
}
