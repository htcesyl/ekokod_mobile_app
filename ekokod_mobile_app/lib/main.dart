
// lib/main.dart
import 'package:ekokod_mobile_app/presentation/home/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EKOKOD',
      home: HomePage(), 
    );
  }
}
