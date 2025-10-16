import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/routes.dart';
import '../../presentation/auth/pages/login_page.dart'; // LoginPage'in yolu
import '../../presentation/start/start_page.dart'; // StartPage'in yolu

class AppRouter {
  static final GoRouter router = GoRouter(
    // Uygulama başladığında gösterilecek ilk rota
    initialLocation: Routes.startRoute,

    routes: [
      // START SAYFASI (Splash/Yükleme Ekranı)
      GoRoute(
        path: Routes.startRoute,
        name: Routes.startRoute,
        builder: (context, state) => const StartPage(),
      ),

      // GİRİŞ SAYFASI
      GoRoute(
        path: Routes.loginRoute,
        name: Routes.loginRoute,
        builder: (context, state) => const LoginPage(),
      ),

      // ANA SAYFA
      GoRoute(
        path: Routes.homeRoute,
        name: Routes.homeRoute,
        builder:
            (context, state) => const Placeholder(
              child: Center(child: Text("Home Page (Ana Sayfa)")),
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
