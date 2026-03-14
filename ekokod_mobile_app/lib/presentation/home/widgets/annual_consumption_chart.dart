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
    final maxY = (maxValue * 1.15).ceilToDouble(); // %15 padding

    return Container(
      height: 280,
      padding: const EdgeInsets.only(left: 4, right: 16, top: 16, bottom: 8),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.start,
          groupsSpace: 35, // Aylar arası boşluk (veri analizi sayfasındaki gibi)
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
                    // Veri analizi sayfası gibi: Sadece bazı ayları göster (tek sayılı aylar + Aralık)
                    final month = date.month;
                    if (month % 2 == 1 || month == 12) {
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
                reservedSize: 48,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  final roundedValue = (value / 100).round() * 100;
                  if (roundedValue >= 0 && roundedValue <= maxY) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        roundedValue.toString(),
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
            show: false, // Veri analizi sayfası gibi grid gösterilmiyor
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
                  color: AppColors.webColor,
                  width: 18, // Bar genişliği (veri analizi sayfasındaki gibi)
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
