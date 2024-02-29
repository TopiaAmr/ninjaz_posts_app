import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz_posts_app/core/services/router.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavigationBloc()),
        BlocProvider(create: (_) => getIt<PostsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Ninjaz Posts',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
