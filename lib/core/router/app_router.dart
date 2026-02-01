import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart';
import 'package:todoapp/presentation/cubit/auth/auth_state.dart';
import 'package:todoapp/presentation/pages/home/home_screen.dart';
import 'package:todoapp/presentation/pages/login/login_screen.dart';
import 'package:todoapp/presentation/pages/register/register_screen.dart';
import 'package:todoapp/presentation/pages/task_detail/task_detail_screen.dart';

abstract class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const detailTask = '/detailTask/:taskId';
}

/// Listenable wrapper cho AuthCubit để GoRouter có thể lắng nghe state changes
class AuthCubitListenable extends ChangeNotifier {
  AuthCubitListenable(this._authCubit) {
    _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  final AuthCubit _authCubit;
}

GoRouter appRouter(AuthCubit authCubit) {
  final authListenable = AuthCubitListenable(authCubit);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = authCubit.state;
      final currentPath = state.uri.path;

      final publicRoutes = [AppRoutes.login, AppRoutes.register];

      if (authState.status == AuthStatus.loading) {
        return null;
      }

      if (authState.status == AuthStatus.authenticated) {
        if (publicRoutes.contains(currentPath)) {
          return AppRoutes.home;
        }
        return null;
      }

      if (authState.status == AuthStatus.unauthenticated ||
          authState.status == AuthStatus.initial ||
          authState.status == null) {
        if (!publicRoutes.contains(currentPath)) {
          return AppRoutes.login;
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.detailTask,
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          return TaskDetailScreen(taskId: taskId);
        },
      ),
    ],
  );
}
