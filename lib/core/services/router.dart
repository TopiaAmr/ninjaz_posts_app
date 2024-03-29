import 'package:go_router/go_router.dart';
import 'package:ninjaz_posts_app/features/bottom_navigation/bottom_navigation.dart';

/// The routes available in the app.
enum AppRoutes {
  /// The home page route.
  home,
}

/// The router for the app.
///
/// This is a singleton and can be accessed using the [router] getter.
GoRouter get router => _router;

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    /// The home page route.
    GoRoute(
      name: AppRoutes.home.name,
      path: '/',
      builder: (context, state) => BottomNavigation(),
    ),
  ],
);
