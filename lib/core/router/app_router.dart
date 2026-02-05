import 'package:go_router/go_router.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit_listenable.dart';
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

GoRouter appRouter(AuthCubit authCubit) {
  final authListenable = AuthCubitListenable(authCubit);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = authCubit.state;
      final currentPath = state.uri.toString();
      final publicRoute = [AppRoutes.login, AppRoutes.register];

      if (authState.status == AuthStatus.authenticated) {
        final String? deepLink = authCubit.deepLink;
        if (deepLink != null) {
          authCubit.clearDeepLink();
          return deepLink;
        }
        if (publicRoute.contains(currentPath)) {
          return AppRoutes.home;
        }
      }

      if (authState.status == AuthStatus.unauthenticated) {
        if (!publicRoute.contains(currentPath)) {
          authCubit.updatedDeepLink(currentPath);
          return AppRoutes.login;
        }
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
