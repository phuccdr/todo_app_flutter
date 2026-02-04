import 'package:flutter/widgets.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart';

class AuthCubitListenable extends ChangeNotifier {
  AuthCubitListenable(this._authCubit) {
    _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }
  final AuthCubit _authCubit;
}
