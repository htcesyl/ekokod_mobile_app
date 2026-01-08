// lib/presentation/analytics/widgets/consumption_chart.dart
// Period'a göre dinamik tüketim grafiği widget'ı

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/chart_entity.dart';
import '../../../domain/shared/enums.dart';
import '../../../core/constants/app_themes.dart';
import 'package:intl/intl.dart';

class ConsumptionChart extends StatelessWidget {
  final List<ChartPointEntity>? data;
  final PeriodType period;

  const ConsumptionChart({
    super.key,
    required this.data,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return Container(
        height: 280,
        color: Colors.grey[100],
        child: Center(
          child: Text(
            _getEmptyMessage(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // En yüksek değeri bul (veri olmayan günleri hariç tut)
    final dataWithValues = data!.where((e) => e.value >= 0).toList();
    final maxValue = dataWithValues.isEmpty 
        ? 100.0 // Varsayılan değer
        : dataWithValues.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final maxY = (maxValue * 1.15).ceilToDouble();

    return Container(
      height: 280,
      padding: const EdgeInsets.only(left: 4, right: 16, top: 16, bottom: 8),
      child: Stack(
        children: [
          // Grafik
          BarChart(
            BarChartData(
              alignment: BarChartAlignment.start,
              groupsSpace: _getGroupsSpace(),
              maxY: maxY,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => AppColors.webColor,
                  tooltipRoundedRadius: 8,
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final date = data![groupIndex].timestamp;
                    final label = _formatTooltipLabel(date);
                    final point = data![groupIndex];
                    final isNoData = point.value < 0;
                    
                    if (isNoData) {
                      return BarTooltipItem(
                        '$label\nVeri Yok',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }
                    
                    final value = rod.toY.toStringAsFixed(2);
                    return BarTooltipItem(
                      '$label\n$value kWh',
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
                    showTitles: period != PeriodType.day, // Günlük period'da tarih etiketleri gösterilmez
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < data!.length) {
                        final date = data![value.toInt()].timestamp;
                        final label = _formatBottomLabel(date, value.toInt());
                        if (label.isEmpty) {
                          return const Text('');
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    reservedSize: period == PeriodType.day ? 20 : 45, // Günlük period'da daha az yer
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
                show: false,
                drawVerticalLine: false,
              ),
              barGroups: data!.asMap().entries.map((entry) {
                final index = entry.key;
                final point = entry.value;
                // Veri olmayan günler için (value: -1) küçük ince çizgi göster
                final isNoData = point.value < 0;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      fromY: 0,
                      toY: isNoData ? maxY * 0.02 : point.value, // Veri yoksa çok küçük bir yükseklik
                      color: isNoData ? Colors.grey[300]! : AppColors.webColor,
                      width: isNoData ? 1.0 : _getBarWidth(), // Veri yoksa çok ince çizgi
                      borderRadius: isNoData 
                          ? BorderRadius.zero // Veri yoksa köşeleri yuvarlatma
                          : const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getEmptyMessage() {
    switch (period) {
      case PeriodType.day:
        return 'Günlük Tüketim Grafiği (Veri Yok)';
      case PeriodType.week:
        return 'Haftalık Tüketim Grafiği (Veri Yok)';
      case PeriodType.month:
        return 'Aylık Tüketim Grafiği (Veri Yok)';
      case PeriodType.year:
        return 'Yıllık Tüketim Grafiği (Veri Yok)';
    }
  }

  double _getGroupsSpace() {
    switch (period) {
      case PeriodType.day:
        return 1; // Günlük veriler için çok az boşluk (365 gün olduğu için)
      case PeriodType.week:
        return 6; // Haftalık veriler için orta boşluk
      case PeriodType.month:
        return 35; // Aylık veriler için belirgin boşluk (aylar arası) - görseldeki gibi
      case PeriodType.year:
        return 40; // Yıllık veriler için belirgin boşluk (yıllar arası) - görseldeki gibi
    }
  }

  double _getBarWidth() {
    switch (period) {
      case PeriodType.day:
        return 2; // Günlük veriler için çok ince (365 gün olduğu için)
      case PeriodType.week:
        return 22; // Haftalık veriler için orta
      case PeriodType.month:
        return 18; // Aylık veriler için daha ince (boşluk daha belirgin olsun)
      case PeriodType.year:
        return 20; // Yıllık veriler için ince (boşluk daha belirgin olsun)
    }
  }

  String _formatTooltipLabel(DateTime date) {
    switch (period) {
      case PeriodType.day:
        return DateFormat('dd/MM/yyyy', 'tr_TR').format(date);
      case PeriodType.week:
        return DateFormat('dd/MM', 'tr_TR').format(date);
      case PeriodType.month:
        return DateFormat('MMM yyyy', 'tr_TR').format(date);
      case PeriodType.year:
        return date.year.toString();
    }
  }

  String _formatBottomLabel(DateTime date, int index) {
    switch (period) {
      case PeriodType.day:
        // Günlük: Her ayın 1'ini ve 15'ini göster, ayrıca her 30 günde bir göster
        // 365 gün olduğu için çok kalabalık olmaması için seyrek göster
        if (date.day == 1 || date.day == 15 || index % 30 == 0) {
          return DateFormat('dd/MM', 'tr_TR').format(date);
        }
        return ''; // Diğer günler için boş string döndür
      case PeriodType.week:
        // Haftalık: Gün göster
        return DateFormat('dd', 'tr_TR').format(date);
      case PeriodType.month:
        // Aylık: Ay göster (Oca, Şub, Mar, vb.)
        return DateFormat('MMM', 'tr_TR').format(date);
      case PeriodType.year:
        // Yıllık: Yıl göster
        return date.year.toString();
    }
  }
}
