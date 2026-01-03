import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_themes.dart';

class MonthNavigator extends StatelessWidget {
  final int currentMonth; // 1-12 arası
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthNavigator({
    super.key,
    required this.currentMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    // Ay adını Türkçe olarak kısaltılmış formatta al (3 harf)
    final monthName = DateFormat('MMM', 'tr_TR').format(
      DateTime(2025, currentMonth, 1),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Geri Ok
        GestureDetector(
          onTap: onPreviousMonth,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.chevron_left, color: AppColors.black, size: 20),
          ),
        ),

        // Ay Metni
        Text(
          monthName,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        // İleri Ok
        GestureDetector(
          onTap: onNextMonth,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.chevron_right, color: AppColors.black, size: 20),
          ),
        ),
      ],
    );
  }
}
