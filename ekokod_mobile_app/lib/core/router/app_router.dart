import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/routes.dart';
import '../../presentation/auth/pages/login_page.dart'; // LoginPage'in yolu
import '../../presentation/start/start_page.dart'; // StartPage'in yolu

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.start,
    routes: [
      GoRoute(
        path: RoutePaths.start,
        name: RouteNames.start,
        builder: (context, state) => const StartPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder:
            (context, state) => const Scaffold(
              body: Center(child: Text("Home Page (Ana Sayfa)")),
            ),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text(
              'Error: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
  );
}
