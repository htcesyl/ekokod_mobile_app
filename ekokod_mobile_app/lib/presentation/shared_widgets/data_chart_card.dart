import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';

// Şimdilik sadece bir Placeholder grafik çiziyoruz.
class EChart extends StatelessWidget {
  const EChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, // Grafiğin yüksekliği
      color: AppColors.white,
      child: Center(
        child: Text(
          "Grafik Placeholder",
          style: TextStyle(color: AppColors.inactiveTabBackground),
        ),
      ),
    );
  }
}

class DataChartCard extends StatelessWidget {
  // Sadece içindeki grafiği alıyoruz. Başlık ve filtreler dışarıda, sayfa kodunda yönetilecek.
  final Widget chartWidget;

  const DataChartCard({super.key, required this.chartWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Kartlar arası dikey boşluk
      margin: const EdgeInsets.symmetric(vertical: 8),
      // Yuvarlak köşeler (Figma taslağına daha uygun)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: AppColors.white, // Kart arkaplanı beyaz

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Veriler Daha Sonra Eklenecek'),

            // SADECE GRAFİK ALANI KALDI
            chartWidget,
          ],
        ),
      ),
    );
  }
}
