import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_themes.dart';
import '../../../core/constants/routes.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/menu_item_card.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  // Çıkış yapma mantığını ve yönlendirmeyi yöneten metot
  void _handleLogout(BuildContext context) {
    // TODO: 1. Kimlik doğrulama Cubit'i (AuthCubit) üzerinden oturumu kapatma işlemi tetiklenecek.

    // 2. Başarılı olursa Login sayfasına yönlendir.
    // GoRouter'da tüm stack'i temizleyip Login sayfasına gitmek için goNamed kullanılır.
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: const CustomAppBar(weatherData: '21°C'),

        bottomNavigationBar: const MainBottomNavBar(
          selectedIndex: 4, // 'Menü' sayfasının indeksi
        ),

        // Sayfa İçeriği
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ------------------------------------
              // 1. PROFİL VE TAHMİN KARTLARI
              // ------------------------------------
              MenuItemCard(
                icon: Icons.person_outline,
                title: 'Profil',
                routeName: RouteNames.profile,
              ),

              MenuItemCard(
                icon: FontAwesomeIcons.chartLine,
                title: 'Tahmin',
                routeName: RouteNames.prediction,
              ),

              const SizedBox(height: 10),
              // ------------------------------------
              // 2. ÇIKIŞ YAP BUTONU (Logout)
              // ------------------------------------
              TextButton(
                onPressed: () => _handleLogout(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Padding'i sıfırlıyoruz
                  minimumSize: Size.fromHeight(60), // Yüksekliği sabitliyoruz
                ),
                child: Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(41),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.inactiveTabBackground,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.red, // Çıkış yapmak için kırmızı renk
                        size: 24,
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Text(
                          'Çıkış Yap',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Sağ ok
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ), // End of TextButton

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
