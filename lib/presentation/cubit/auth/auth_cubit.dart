import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/usecase/get_user_usecase.dart';
import 'package:todoapp/presentation/cubit/auth/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final GetUserUsecase _getUserUsecase;
  AuthCubit(this._getUserUsecase)
      : super(const AuthState(status: AuthStatus.unauthenticated));
  void checkLoggedIn() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _getUserUsecase.execute();
    result.fold(
      (e) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (user) {
        emit(state.copyWith(user: user, status: AuthStatus.authenticated));
      },
    );
  }
}
