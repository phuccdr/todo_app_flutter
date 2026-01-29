import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@injectable
class LoginUsecase {
  final AuthRepository _authRepo;
  LoginUsecase(this._authRepo);
  Future<Either<Failure, void>> excute(String email, String password) {
    return _authRepo.login(email, password);
  }
}
