import 'package:flutter/material.dart';

class AppColors {
  //Splash/Login sayfası arka plan renkleri
  static const Color darkGreen = Color(0xFF052E07);
  static const Color mediumDarkGreen = Color(0xFF184218);
  static const Color mediumGreen = Color(0xFF1B441A);
  static const Color lightGreen = Color(0xFF396334);
  static const Color veryLightGreen = Color(0xFF7D967A);

  //secondBackground
  static const Color pastelGreen = Color(0xFF5B965C);

  // login Giriş Kartı Arkaplan Rengi (Örnek açık gri)
  static const Color cardBackground = Color(
    0xFFEBEBEB,
  ); // Taslak ekrandaki açık gri

  // Tab Selector Renkleri
  static const Color activeTabBackground = Color(
    0x99DEFA60,
  ); // Aktif Tab Arkaplanı
  static const Color inactiveTabBackground = Color(
    0x33D9D9D9, //0x33 ≈ %20 alfa (opacity)
  ); // Aktif Olmayan Tab Arkaplanı (üretim, tüketim, karbon ayak izi)

  //period selector renkleri
  static const Color activePeriodBackGround = Color(
    0xFFD9D9D9,
  ); //aktif period rengi

  // Diğer renkler
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

//Splash/Login sayfası arka plan gradyanı tanımı
const LinearGradient appBackgroundGradient = LinearGradient(
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

//SecondBackground for home, analytics bills...
const LinearGradient secondBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.93],
  colors: [AppColors.pastelGreen, AppColors.white],
);
