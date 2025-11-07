import 'package:ekokod_mobile_app/presentation/alarms/pages/alarms_page.dart';
import 'package:ekokod_mobile_app/presentation/bills/pages/bills_page.dart';
import 'package:ekokod_mobile_app/presentation/home/pages/home_page.dart';
import 'package:ekokod_mobile_app/presentation/menu/pages/menu_pages.dart';
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
      GoRoute(
        path: RoutePaths.bills,
        name: RouteNames.bills,
        builder: (context, state) => const BillsPage(),
      ),
      // Alarm Sayfası Placeholder'ı
      GoRoute(
        path: RoutePaths.alarms,
        name: RouteNames.alarms,
        builder: (context, state) => const AlarmPage(),
      ),
      GoRoute(
        path: RoutePaths.menu,
        name: RouteNames.menu,
        builder: (context, state) => const MenuPage(),
        routes: [
          GoRoute(
            path: RoutePaths.profile, // Tam yol: /menu/profile
            name: RouteNames.profile,
            builder:
                (context, state) => const Placeholder(
                  child: Center(child: Text("Profil Sayfası")),
                ),
          ),

          GoRoute(
            path: RoutePaths.prediction, // Tam yol: /menu/prediction
            name: RouteNames.prediction,
            builder:
                (context, state) => const Placeholder(
                  child: Center(child: Text("Tahmin Sayfası")),
                ),
          ),
        ],
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
