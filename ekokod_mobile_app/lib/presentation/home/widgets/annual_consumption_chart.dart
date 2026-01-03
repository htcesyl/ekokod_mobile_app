// lib/presentation/home/widgets/annual_consumption_chart.dart
// Yıllık tüketim grafiği widget'ı

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/chart_entity.dart';
import '../../../core/constants/app_themes.dart';
import 'package:intl/intl.dart';

class AnnualConsumptionChart extends StatelessWidget {
  final List<ChartPointEntity>? data;

  const AnnualConsumptionChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return Container(
        height: 280, // 200'den 280'e büyütüldü (grafik ile aynı yükseklik)
        color: Colors.grey[100],
        child: const Center(
          child: Text(
            'Yıllık Tüketim Grafiği (Veri Yok)',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // En yüksek değeri bul (grafik yüksekliği için)
    final maxValue = data!.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final maxY = (maxValue * 1.15).ceilToDouble(); // %15 padding (daha kompakt)

    return Container(
      height: 280, // 200'den 280'e büyütüldü
      padding: const EdgeInsets.only(left: 4, right: 16, top: 16, bottom: 8), // Sol padding azaltıldı (grafik sola kaydı)
      child: Stack(
        children: [
          // Önce grafiği çiz
          BarChart(
            BarChartData(
              alignment: BarChartAlignment.start, // Start alignment (daha kontrollü)
              groupsSpace: 8, // Bar'lar arası sabit boşluk (8px)
              maxY: maxY,
              barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.webColor,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final monthName = DateFormat('MMM', 'tr_TR').format(data![groupIndex].timestamp);
                final value = rod.toY.toStringAsFixed(2);
                return BarTooltipItem(
                  '$monthName\n$value kWh',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < data!.length) {
                    final date = data![value.toInt()].timestamp;
                    final monthName = DateFormat('MMM', 'tr_TR').format(date);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        monthName,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11, // 10'dan 11'e büyütüldü
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 45, // 40'tan 45'e artırıldı (daha fazla boşluk)
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48, // 55'ten 48'e azaltıldı (grafik daha sola kayar)
                interval: maxY / 4, // 4 bölüm
                getTitlesWidget: (value, meta) {
                  // Yuvarlanmış değerler göster
                  final roundedValue = (value / 100).round() * 100; // 100'ün katları
                  if (roundedValue >= 0 && roundedValue <= maxY) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        roundedValue.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w600, // w500'den w600'e (daha belirgin)
                        ),
                        textAlign: TextAlign.right,
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              left: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          gridData: FlGridData(
            show: false, // Yatay grid çizgileri kapalı
            drawVerticalLine: false, // fl_chart'ın dikey çizgileri kapalı (CustomPaint kullanıyoruz)
          ),
          barGroups: data!.asMap().entries.map((entry) {
            final index = entry.key;
            final point = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: point.value,
                  color: AppColors.webColor,
                  width: 26, // 24'ten 26'ya (daha kalın ve belirgin)
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8), // 6'dan 8'e (daha yuvarlak)
                  ),
                ),
              ],
            );
          }).toList(),
            ),
          ),
          // Sonra dikey çizgileri çiz (üstte görünsün)
          Positioned.fill(
            left: 48, // left reserved size
            right: 16, // right padding
            top: 0,
            bottom: 45, // bottom reserved size
            child: CustomPaint(
              painter: _VerticalLinePainter(
                dataLength: data!.length,
                lineColor: Colors.grey[300]!,
                barWidth: 26.0, // Bar genişliği (BarChartRodData width ile aynı)
                groupsSpace: 8.0, // Bar'lar arası boşluk (BarChartData.groupsSpace ile aynı)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bar'lar arasındaki dikey çizgileri çizen CustomPainter
class _VerticalLinePainter extends CustomPainter {
  final int dataLength;
  final Color lineColor;
  final double barWidth;
  final double groupsSpace; // Bar'lar arası boşluk (BarChartData.groupsSpace ile aynı)

  _VerticalLinePainter({
    required this.dataLength,
    required this.lineColor,
    required this.barWidth,
    required this.groupsSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Start alignment için: Her bar'ın pozisyonu = index * (barWidth + groupsSpace)
    // İlk bar 0'dan başlar, sonraki bar'lar (barWidth + groupsSpace) kadar ilerler
    
    // Her bar'ın SAĞ KENARINDAN (bitiş noktasından) çizgi çiz
    for (int i = 0; i < dataLength - 1; i++) {
      // Bar'ın başlangıç pozisyonu (start alignment)
      final barStartX = i * (barWidth + groupsSpace);
      // Bar'ın bitiş pozisyonu (sağ kenarı)
      final barEndX = barStartX + barWidth;
      
      // Çizgiyi bar'ın sağ kenarından çek
      canvas.drawLine(
        Offset(barEndX, 0),
        Offset(barEndX, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
