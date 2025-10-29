import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';

class YearNavigator extends StatelessWidget {
  final int currentYear;
  final VoidCallback onPreviousYear;
  final VoidCallback onNextYear;

  const YearNavigator({
    super.key,
    required this.currentYear,
    required this.onPreviousYear,
    required this.onNextYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Geri Ok
        GestureDetector(
          onTap: onPreviousYear,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.chevron_left, color: AppColors.black),
          ),
        ),

        // Yıl Metni
        Text(
          currentYear.toString(),
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        // İleri Ok
        GestureDetector(
          onTap: onNextYear,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.chevron_right, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
