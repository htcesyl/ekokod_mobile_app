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

    // En yüksek değeri bul
    final maxValue = data!.map((e) => e.value).reduce((a, b) => a > b ? a : b);
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
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < data!.length) {
                        final date = data![value.toInt()].timestamp;
                        final label = _formatBottomLabel(date);
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
                show: false,
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
                      width: _getBarWidth(),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          // Dikey çizgiler
          Positioned.fill(
            left: 48,
            right: 16,
            top: 0,
            bottom: 45,
            child: CustomPaint(
              painter: _VerticalLinePainter(
                dataLength: data!.length,
                lineColor: Colors.grey[300]!,
                barWidth: _getBarWidth(),
                groupsSpace: _getGroupsSpace(),
              ),
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
        return 4; // Günlük veriler için daha az boşluk
      case PeriodType.week:
        return 6; // Haftalık veriler için orta boşluk
      case PeriodType.month:
        return 8; // Aylık veriler için normal boşluk
      case PeriodType.year:
        return 8; // Yıllık veriler için normal boşluk
    }
  }

  double _getBarWidth() {
    switch (period) {
      case PeriodType.day:
        return 20; // Günlük veriler için daha ince
      case PeriodType.week:
        return 22; // Haftalık veriler için orta
      case PeriodType.month:
        return 24; // Aylık veriler için normal
      case PeriodType.year:
        return 26; // Yıllık veriler için kalın
    }
  }

  String _formatTooltipLabel(DateTime date) {
    switch (period) {
      case PeriodType.day:
        return DateFormat('dd/MM/yyyy', 'tr_TR').format(date);
      case PeriodType.week:
        return DateFormat('dd/MM', 'tr_TR').format(date);
      case PeriodType.month:
        return DateFormat('dd/MM', 'tr_TR').format(date);
      case PeriodType.year:
        return DateFormat('MMM yyyy', 'tr_TR').format(date);
    }
  }

  String _formatBottomLabel(DateTime date) {
    switch (period) {
      case PeriodType.day:
        // Günlük: Saat göster (eğer saatlik veri varsa) veya gün
        return DateFormat('dd', 'tr_TR').format(date);
      case PeriodType.week:
        // Haftalık: Gün göster
        return DateFormat('dd', 'tr_TR').format(date);
      case PeriodType.month:
        // Aylık: Gün göster
        return DateFormat('dd', 'tr_TR').format(date);
      case PeriodType.year:
        // Yıllık: Ay göster
        return DateFormat('MMM', 'tr_TR').format(date);
    }
  }
}

// Bar'lar arasındaki dikey çizgileri çizen CustomPainter
class _VerticalLinePainter extends CustomPainter {
  final int dataLength;
  final Color lineColor;
  final double barWidth;
  final double groupsSpace;

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

    for (int i = 0; i < dataLength - 1; i++) {
      final barStartX = i * (barWidth + groupsSpace);
      final barEndX = barStartX + barWidth;
      
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
