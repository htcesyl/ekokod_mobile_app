import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_themes.dart';

class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;

  // Tıklanınca GoRouter ile yönlendirme yapar
  final VoidCallback? onTap;

  const MenuItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.routeName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap verilmezse varsayılan olarak GoRouter ile yönlendir
      onTap: onTap ?? () => context.goNamed(routeName),
      child: Container(
        height: 60, // Sabit yükseklik, daha şık bir görünüm için
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.white, // Beyaz arkaplan
          borderRadius: BorderRadius.circular(41), // Yuvarlak köşeler
          border: Border.all(color: Color(0x1A000000), width: 1.0),
        ),
        child: Row(
          children: [
            // İkon
            Icon(
              icon,
              color: AppColors.mediumGreen, // Ana yeşil tonunu kullanabiliriz
              size: 24,
            ),
            const SizedBox(width: 15),

            // Başlık Metni
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Sağ ok (opsiyonel)
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
