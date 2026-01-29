import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/auth_repository/auth_repository.dart';

@injectable
class CheckLoggedinUsecase {
  final AuthRepository _authRepository;
  const CheckLoggedinUsecase(this._authRepository);
  Future<Either<Failure, bool>> execute() async {
    return _authRepository.isLoggedIn();
  }
}
