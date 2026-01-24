import 'package:go_router/go_router.dart';
import 'package:todoapp/presentation/pages/home/home_screen.dart';
import 'package:todoapp/presentation/pages/login/login_screen.dart';
import 'package:todoapp/presentation/pages/register/register_screen.dart';

abstract class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
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
  ],
);
