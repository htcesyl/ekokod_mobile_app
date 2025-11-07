import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String weatherData;

  const CustomAppBar({required this.weatherData, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Geri butonu otomatik çıkmasın
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 72,
      titleSpacing: 22,
      centerTitle: false,
      title: Image.asset(AppAssets.logo, height: 65, fit: BoxFit.contain),

      actions: [
        // Hava Durumu Göstergesi
        Row(
          children: [
            const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),
            const SizedBox(width: 4),
            Text(
              weatherData, // API'den gelecek verinin yer tutucusu
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30); // Başlığa yer açmak için biraz daha yüksek
}
