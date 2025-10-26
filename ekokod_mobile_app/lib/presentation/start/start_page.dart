import 'package:flutter/material.dart';
import 'package:ekokod_mobile_app/core/constants/app_themes.dart';
import 'package:ekokod_mobile_app/core/constants/routes.dart';
import 'package:go_router/go_router.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    // Uygulama başlatıldığında yapılması gereken asenkron işlemler burada başlar:
    _initializeApp();
  }

  // Asenkron başlatma fonksiyonu
  void _initializeApp() async {
    // 1. Gerekli bağımlılıkları (GetIt) başlat. (Sınıfın yüklenmesini bekler)
    // await initDependencies();

    // 2. Minimum bekleme süresi (Görselin görünmesi için)
    await Future.delayed(const Duration(seconds: 2));

    // 4. GoRouter ile yönlendir:
    if (mounted) {
      // Widget'ın hala ekranda olup olmadığını kontrol ediyoruz.
      context.goNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Arka Plan Gradient (app_themes.dart tan alıyoruz.)
      body: Container(
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: const Center(
          child: Text(
            'EKOKOD',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
