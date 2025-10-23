// lib/main.dart
import 'package:ekokod_mobile_app/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ekokod_mobile_app/presentation/start/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EKOKOD',
      // Temayı buradan besleyebiliriz.
      // home: StartPage(), // GoRouter kullanacağımız için bu satır yerine router'ı tanımlayacağız.
      // Şimdilik test etmek için home'u kullanabiliriz:
      // DEBUG yazısını kaldıran ayar BURASIDIR:
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
    );
  }
}