import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart';

@injectable
class FetchCategoriesUseCase {
  final CategoryRepository _categoryRepository;
  FetchCategoriesUseCase(this._categoryRepository);
  Future<Either<Failure, void>> execute() {
    return _categoryRepository.fetchCategoriesFromServer().run().then(
      (e) => e.map((_) {}),
    );
  }
}
