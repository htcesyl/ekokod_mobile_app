<<<<<<< HEAD
// lib/main.dart
import 'package:ekokod_mobile_app/presentation/home/pages/home_page.dart';
=======
>>>>>>> 7da80107e72cf01863309fa3178c939c2c796ce9
import 'package:flutter/material.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,

      title: 'EKOKOD',
      // Temayı buradan besleyebiliriz.
      // home: StartPage(), // GoRouter kullanacağımız için bu satır yerine router'ı tanımlayacağız.
      // Şimdilik test etmek için home'u kullanabiliriz:
<<<<<<< HEAD
      // DEBUG yazısını kaldıran ayar BURASIDIR:
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
=======
>>>>>>> 7da80107e72cf01863309fa3178c939c2c796ce9
    );
  }
}
