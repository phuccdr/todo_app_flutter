import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/data/datasource/local/share_pref/prefs.dart';
import 'package:todoapp/data/datasource/remote/auth_remote_datasource.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Prefs _prefs;
  final AuthRemoteDataSource _authRemote;

  AuthRepositoryImpl(this._prefs, this._authRemote);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      final response = await _authRemote.login(email, password);
      final userModel = response;
      final isSaved = await _prefs.saveUser(userModel);
      return isSaved ? Right(null) : Left(Failure(message: 'Login Failure'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(String email, String password) async {
    try {
      final response = await _authRemote.register(email, password);
      return response ? Right(null) : Left(Failure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = _prefs.isLoggedIn();
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }
}
