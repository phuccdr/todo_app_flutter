import 'package:equatable/equatable.dart';
import 'package:todoapp/domain/entities/user.dart';

class AuthState extends Equatable {
  final User? user;
  final bool? isLoggedIn;
  const AuthState({this.user, this.isLoggedIn});

  AuthState copyWith({User? user, bool? isLoggedIn}) {
    return AuthState(
      user: user ?? this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [user, isLoggedIn];
}
