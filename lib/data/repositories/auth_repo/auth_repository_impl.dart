import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/data/datasource/local/share_pref/prefs.dart';
import 'package:todoapp/data/datasource/remote/auth_remote_datasource.dart';
import 'package:todoapp/domain/entities/user.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Prefs _prefs;
  final AuthRemoteDataSource _authRemote;

  AuthRepositoryImpl(this._prefs, this._authRemote);

  @override
  TaskEither<Failure, Unit> login(String email, String password) {
    return TaskEither.Do(($) async {
      final userModel = await $(
        TaskEither.tryCatch(
          () => _authRemote.login(email, password),
          (e, _) => Failure(message: e.toString()),
        ),
      );

      await $(
        TaskEither.tryCatch(
          () => _prefs.saveUser(userModel),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      return unit;
    });
  }

  @override
  TaskEither<Failure, Unit> register(String email, String password) {
    return TaskEither.tryCatch(() async {
      await _authRemote.register(email, password);
      return unit;
    }, (e, _) => Failure(message: e.toString()));
  }

  @override
  TaskEither<Failure, User> getUser() {
    return TaskEither.tryCatch(() async {
      final model = _prefs.getUser();
      if (model == null) {
        throw Exception('User not found');
      }
      return model.toEntity();
    }, (e, _) => Failure(message: e.toString()));
  }
}
