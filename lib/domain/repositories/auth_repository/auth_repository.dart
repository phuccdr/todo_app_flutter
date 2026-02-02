import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/user.dart';

abstract class AuthRepository {
  TaskEither<Failure, Unit> login(String email, String password);
  TaskEither<Failure, Unit> register(String email, String password);
  TaskEither<Failure, User> getUser();
}
