import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/usecase/check_loggedin_usecase.dart';
import 'package:todoapp/presentation/cubit/auth/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final CheckLoggedinUsecase _checkLoggedinUsecase;
  AuthCubit(this._checkLoggedinUsecase) : super(AuthState());
}
