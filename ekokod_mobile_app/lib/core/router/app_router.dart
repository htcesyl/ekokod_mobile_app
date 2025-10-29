import 'package:ekokod_mobile_app/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/routes.dart';
import '../../presentation/auth/pages/login_page.dart';
import '../../presentation/start/start_page.dart';
import '../../presentation/analytics/pages/analytics_page.dart';

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
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePaths.analytics,
        name: RouteNames.analytics,
        builder: (context, state) => const AnalyticsPage(),
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
