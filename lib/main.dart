import 'package:flutter/material.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/router/app_router.dart';
import 'package:todoapp/core/theme/app_theme.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: AppTheme.dark,
    );
  }
}
