import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/data/datasource/local/local_data_source/category_local_datasource.dart';
import 'package:todoapp/data/datasource/remote/category_remote_datasource.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/repositories/category_repository/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource _remoteDatasource;
  final CategoryLocalDatasource _localDataSource;
  CategoryRepositoryImpl(this._remoteDatasource, this._localDataSource);

  @override
  TaskEither<Failure, Unit> fetchCategoriesFromServer() {
    return TaskEither.Do(($) async {
      final remoteCategoies = await $(
        TaskEither.tryCatch(
          () => _remoteDatasource.getCategories(),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      await $(
        TaskEither.tryCatch(
          () => _localDataSource.insertCategories(remoteCategoies),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      return unit;
    });
  }

  @override
  Stream<Either<Failure, List<Category>>> watchCategories() {
    return _localDataSource.watchCategories().map(
      (categories) => Right(categories.map((c) => c.toEntity()).toList()),
    );
  }

  @override
  TaskEither<Failure, Category?> getCategoryById(String categoryId) {
    return TaskEither.tryCatch(() async {
      final model = await _localDataSource.getCategoryById(categoryId);
      return model?.toEntity();
    }, (e, _) => Failure(message: e.toString()));
  }
}
