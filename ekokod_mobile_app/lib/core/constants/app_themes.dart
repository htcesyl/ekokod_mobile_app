import 'package:flutter/material.dart';

class AppColors {
  //Splash/Login sayfası arka plan renkleri
  static const Color darkGreen = Color(0xFF052E07);
  static const Color mediumDarkGreen = Color(0xFF184218);
  static const Color mediumGreen = Color(0xFF1B441A);
  static const Color lightGreen = Color(0xFF396334);
  static const Color veryLightGreen = Color(0xFF7D967A);
  static const Color pastelGreen = Color(0xFF5B965C);

  // login Giriş Kartı Arkaplan Rengi (Örnek açık gri)
  static const Color cardBackground = Color(
    0xFFEBEBEB,
  ); 

  static const Color webColor = Color(0xFF09a42b);

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

  // Gri tonları
  static const Color lightGray = Color(0xFFE5E5E5);
  static const Color mediumGray = Color(0xFFD9D9D9);
  static const Color darkGray = Color(0xFFB0B0B0);
  static const Color veryDarkGray = Color(0xFF1E1E1E);

  // Diğer renkler
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

//Splash/Login sayfası arka plan gradyanı tanımı
const LinearGradient appBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.40, 0.99], 
  colors: [ 
    AppColors.white,
    AppColors.mediumGray,
    AppColors.webColor,
  ],
);

//SecondBackground for home, analytics bills...
const LinearGradient secondBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.99],
  colors: [AppColors.mediumGray, AppColors.white],
);
