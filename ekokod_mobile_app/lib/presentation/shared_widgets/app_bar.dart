// lib/presentation/shared_widgets/app_bar.dart
/*appBar: const CustomAppBar(
  pageTitle: 'Faturalar', 
  weatherData: '18°C',           Bu kısmı kullanarak her sayfaya ait appBar'ı oluşturabiliriz.
),
*/
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // 1. ZORUNLU PARAMETRE: Hangi sayfada olduğumuzu belirtir (Anasayfa, Faturalar, vb.).
  final String pageTitle;

  // 2. ZORUNLU PARAMETRE: Hava durumu verisi (API'den gelene kadar yer tutucu/zorunlu metin).
  final String weatherData;

  const CustomAppBar({
    required this.pageTitle,
    required this.weatherData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // AppBar widget'ını döndürüyoruz
    return AppBar(
      automaticallyImplyLeading: false, // Geri butonu otomatik çıkmasın
      backgroundColor: Colors.transparent,
      elevation: 0,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // EKOKOD Başlığı (Sabit)
          const Text(
            'EKOKOD',
            style: TextStyle(
              color: Color(0xFF1B441A), // Koyu yeşil renk
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          // ⬅️ ZORUNLU PARAMETRE: Sayfa Adı
          Text(
            pageTitle, // Her sayfada değişecek
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      actions: [
        // Hava Durumu Göstergesi (Sağ Taraf)
        Row(
          children: [
            const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),
            const SizedBox(width: 4),
            // ⬅️ ZORUNLU PARAMETRE: Hava Durumu Verisi
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

  // AppBar'ın yüksekliğini tanımlamak zorunludur.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40); // Başlığa yer açmak için biraz daha yüksek
}
