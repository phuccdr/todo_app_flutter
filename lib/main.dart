import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/router/app_router.dart';
import 'package:todoapp/core/theme/app_theme.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    BlocProvider(
      create: (_) => getIt<AuthCubit>()..checkLoggedIn(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter(context.read<AuthCubit>()),
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: AppTheme.dark,
    );
  }
}
