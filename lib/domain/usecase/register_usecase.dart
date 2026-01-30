import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@injectable
class RegisterUsecase {
  final AuthRepository _authRepo;
  const RegisterUsecase(this._authRepo);
  Future<Either<Failure, void>> excute(String email, String password) {
    return _authRepo.register(email, password);
  }
}
