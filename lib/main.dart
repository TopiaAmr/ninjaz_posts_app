import 'package:flutter/material.dart';
import 'package:ninjaz_posts_app/core/res/colors.dart';
import 'package:ninjaz_posts_app/core/services/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ninjaz Posts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primary,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
      ),
      routerConfig: router,
    );
  }
}
