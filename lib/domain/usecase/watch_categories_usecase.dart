import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart';

@injectable
class WatchCategoriesUsecase {
  final CategoryRepository _categoryRepo;
  const WatchCategoriesUsecase(this._categoryRepo);
  Stream<Either<Failure, List<Category>>> execute() {
    return _categoryRepo.watchCategories();
  }
}
