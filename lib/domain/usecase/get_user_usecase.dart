import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/user.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@injectable
class GetUserUsecase {
  final AuthRepository _authRepo;
  const GetUserUsecase(this._authRepo);
  Future<Either<Failure, User>> execute() {
    return _authRepo.getUser();
  }
}
