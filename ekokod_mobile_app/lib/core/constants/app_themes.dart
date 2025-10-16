import 'package:flutter/material.dart';

class AppColors {
  // Splash Screen Arka Plan Gradient'i için kullanılan renkler
  static const Color darkGreen = Color(0xFF052E07); // %0 Stop
  static const Color mediumDarkGreen = Color(0xFF184218); // %19 Stop
  static const Color mediumGreen = Color(0xFF1B441A); // %36 Stop
  static const Color lightGreen = Color(0xFF396334); // %66 Stop
  static const Color veryLightGreen = Color(0xFF7D967A); // %100 Stop

  // login Giriş Kartı Arkaplan Rengi (Örnek açık gri)
  static const Color cardBackground = Color(
    0xFFEBEBEB,
  ); // Taslak ekrandaki açık gri

  // ... Diğer renkler (beyaz, gri vb.)
  static const Color white = Colors.white;
}

// Login Full Arkaplan Gradyanı Tanımı
const LinearGradient loginBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.19, 0.36, 0.66, 1.0], // Gönderdiğiniz oranlar
  colors: [
    AppColors.darkGreen,
    AppColors.mediumDarkGreen,
    AppColors.mediumGreen,
    AppColors.lightGreen,
    AppColors.veryLightGreen,
  ],
);
