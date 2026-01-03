import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_themes.dart';

class DayNavigator extends StatelessWidget {
  final DateTime currentDay;
  final VoidCallback onPreviousDay;
  final VoidCallback onNextDay;

  const DayNavigator({
    super.key,
    required this.currentDay,
    required this.onPreviousDay,
    required this.onNextDay,
  });

  @override
  Widget build(BuildContext context) {
    // Tarihi Türkçe formatında göster (örn: "2 Oca")
    final dayFormat = DateFormat('d MMM', 'tr_TR');
    final dayText = dayFormat.format(currentDay);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Geri Ok
        GestureDetector(
          onTap: onPreviousDay,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.chevron_left, color: AppColors.black, size: 20),
          ),
        ),

        // Gün Metni
        Text(
          dayText,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        // İleri Ok
        GestureDetector(
          onTap: onNextDay,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.chevron_right, color: AppColors.black, size: 20),
          ),
        ),
      ],
    );
  }
}
