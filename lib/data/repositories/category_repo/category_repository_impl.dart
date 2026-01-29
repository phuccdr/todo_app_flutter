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
  Future<Either<Failure, void>> fetchCategoriesFromServer() async {
    try {
      final remoteCategories = await _remoteDatasource.getCategories();
      await _localDataSource.insertCategories(remoteCategories);
      return Right(null);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Stream<Either<Failure, List<Category>>> watchCategories() {
    return _localDataSource.watchCategories().map(
      (categories) => Right(categories.map((c) => c.toEntity()).toList()),
    );
  }
}
