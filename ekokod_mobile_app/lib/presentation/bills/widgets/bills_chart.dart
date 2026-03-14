// lib/presentation/bills/widgets/bills_chart.dart
// Faturalar grafiği widget'ı (Son 12 ay)

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/chart_entity.dart';
import '../../../core/constants/app_themes.dart';
import 'package:intl/intl.dart';

class BillsChart extends StatelessWidget {
  final List<ChartPointEntity>? data;

  const BillsChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return Container(
        height: 280,
        color: Colors.grey[100],
        child: const Center(
          child: Text(
            'Fatura Grafiği (Veri Yok)',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // En yüksek değeri bul (grafik yüksekliği için)
    final maxValue = data!.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final maxY = maxValue > 0 ? (maxValue * 1.15).ceilToDouble() : 1000.0; // Minimum 1000 TL

    return Container(
      height: 280,
      padding: const EdgeInsets.only(left: 4, right: 16, top: 16, bottom: 8),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.start,
          groupsSpace: 35, // Aylar arası boşluk (tüketim grafiği gibi)
          maxY: maxY,
          minY: 0,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.webColor,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (groupIndex >= 0 && groupIndex < data!.length) {
                  final monthName = DateFormat('MMM yyyy', 'tr_TR').format(data![groupIndex].timestamp);
                  final value = rod.toY.toStringAsFixed(2);
                  return BarTooltipItem(
                    '$monthName\n₺ $value',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }
                return null;
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
                    // Tüketim grafiği gibi: Sadece bazı ayları göster (her 2 ayda bir)
                    // Oca, Mar, May, Tem, Eyl, Kas gibi
                    final month = date.month;
                    // Sadece tek sayılı ayları göster (1, 3, 5, 7, 9, 11) veya her ayı göster
                    // Kullanıcı görselinde her 2 ayda bir görünüyor, ama 12 ay için hepsini gösterelim
                    // Alternatif: Sadece tek sayılı ayları göster
                    if (month % 2 == 1 || month == 12) { // Tek sayılı aylar + Aralık
                      final monthName = DateFormat('MMM', 'tr_TR').format(date);
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          monthName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  }
                  return const Text('');
                },
                reservedSize: 45,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48, // Tüketim grafiği gibi
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  // Tüketim grafiği gibi: Yuvarlanmış değerler göster
                  final roundedValue = (value / 1000).round() * 1000; // 1000'in katları
                  if (roundedValue >= 0 && roundedValue <= maxY) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        '₺ ${(roundedValue / 1000).toStringAsFixed(0)}K',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
            show: false, // Tüketim grafiği gibi grid gösterilmiyor
            drawVerticalLine: false,
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
                  color: point.value > 0 ? AppColors.webColor : Colors.grey[300]!,
                  width: 18, // Bar genişliği (tüketim grafiği gibi - boşluk daha belirgin olsun)
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
