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
  Stream<Either<Failure, List<Category>>> getCategories() async* {
    bool isLoadedLocal = false;
    try {
      final localCategories = await _localDataSource.getCategories();
      if (localCategories.isNotEmpty) {
        yield Right(localCategories.map((c) => c.toEntity()).toList());
        isLoadedLocal = true;
      }
    } catch (_) {}

    try {
      final remoteCategories = await _remoteDatasource.getCategories();
      await _localDataSource.insertCategories(remoteCategories);
      yield Right(remoteCategories.map((c) => c.toEntity()).toList());
    } catch (e) {
      if (!isLoadedLocal) {
        yield Left(Failure(message: e.toString()));
      }
    }
  }

  @override
  Stream<Either<Failure, List<Category>>> watchCategories() {
    return _localDataSource.watchCategories().map(
      (categories) => Right(categories.map((c) => c.toEntity()).toList()),
    );
  }
}
