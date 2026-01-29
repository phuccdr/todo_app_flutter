import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, void>> register(String email, String password);
}
