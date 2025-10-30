import 'package:flutter/material.dart';
import '../../core/constants/app_themes.dart';
// Domain katmanından PeriodType enum'ını import ediyoruz
import '../../domain/shared/enums.dart';

class PeriodSelector extends StatelessWidget {
  // Seçili olan periyot (Gün, Ay, Yıl, vb.)
  final PeriodType selectedPeriod;
  // Periyot tıklandığında Cubit'i tetiklemek için kullanılan callback
  final ValueChanged<PeriodType> onPeriodSelected;

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  // Dönem seçim düğmelerini oluşturmak için yardımcı metot
  Widget _buildPeriodButton({
    required PeriodType period,
    required String label,
  }) {
    final bool isSelected = period == selectedPeriod;

    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodSelected(period),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            // Aktif butonda activePeriodBackGround (D9D9D9), pasifte Beyaz (AppColors.white)
            color:
                isSelected ? AppColors.activePeriodBackGround : AppColors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 278,
      height: 34,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30), // Yüksek corner radius
        border: Border.all(color: Color(0x1A000000), width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPeriodButton(period: PeriodType.day, label: 'Gün'),
          _buildPeriodButton(period: PeriodType.week, label: 'Hafta'),
          _buildPeriodButton(period: PeriodType.month, label: 'Ay'),
          _buildPeriodButton(period: PeriodType.year, label: 'Yıl'),
        ],
      ),
    );
  }
}
