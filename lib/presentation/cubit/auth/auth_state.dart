import 'package:equatable/equatable.dart';
import 'package:todoapp/domain/entities/user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated }

class AuthState extends Equatable {
  final User? user;
  final AuthStatus? status;
  const AuthState({this.user, this.status});

  AuthState copyWith({User? user, AuthStatus? status}) {
    return AuthState(user: user ?? this.user, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [user, status];
}
