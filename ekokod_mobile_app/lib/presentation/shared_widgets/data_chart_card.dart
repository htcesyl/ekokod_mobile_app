import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';

// Şimdilik sadece bir Placeholder grafik çiziyoruz.
class MockChart extends StatelessWidget {
  const MockChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, // Grafiğin yüksekliği
      color: Colors.white, // Zemin rengi
      child: Center(
        child: Text(
          "Grafik Placeholder",
          style: TextStyle(color: AppColors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}

class DataChartCard extends StatelessWidget {
  final String title; // "Tüketim - Bu Yıl" gibi başlık
  final Widget chartWidget; // MockChart veya gerçek bir BarChart/LineChart
  final Widget?
  rightHeaderWidget; // Sağ üst köşedeki "Bina 1" veya "Hafta İçi" gibi filtreler

  const DataChartCard({
    super.key,
    required this.title,
    required this.chartWidget,
    this.rightHeaderWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sol Başlık
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                // Sağdaki Filtre (Bina 1)
                if (rightHeaderWidget != null) rightHeaderWidget!,
              ],
            ),
            const SizedBox(height: 15),

            // Grafik Alanı
            chartWidget,
          ],
        ),
      ),
    );
  }
}
