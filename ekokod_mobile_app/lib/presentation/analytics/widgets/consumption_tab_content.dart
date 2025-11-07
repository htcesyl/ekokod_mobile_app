import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../../core/constants/app_themes.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';

class ConsumptionTabContent extends StatelessWidget {
  final PeriodType selectedPeriod;
  final String selectedBuilding;
  final List<String> availableBuildings;
  final ValueChanged<String?> onBuildingChanged;

  const ConsumptionTabContent({
    super.key,
    required this.selectedPeriod,
    required this.selectedBuilding,
    required this.availableBuildings,
    required this.onBuildingChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Yük Profili Dropdown'ı için mock data
    final List<String> profileOptions = [
      'Hafta İçi',
      'Hafta Sonu',
      'Tüm Günler',
    ];

    final List<String> seasonOptions = ['İlkbahar', 'Yaz', 'Sonbahar', 'Kış'];

    return Column(
      children: [
        // ----------------------------------------
        // 1. Tüketim Grafiği (Bar Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - DOĞRUDAN ROW KULLANIMI)
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Sol Başlık
              const Text(
                'Tüketim',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),

        // GRAFİK KARTI (Sadece beyaz arkaplan ve grafik)
        const DataChartCard(chartWidget: EChart()),

        const SizedBox(height: 15),

        // ----------------------------------------
        // 2. Yük Profili Grafiği (Line Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sol Başlık
              const Text(
                'Yük Profili',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),

              const Spacer(),

              // Sağ Filtre (Yük Profili Dropdown)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropdown(
                    label: '',
                    selectedItem: 'Sonbahar',
                    items: seasonOptions,
                    onChanged: (val) {
                      // TODO: Yük profili filtresini yönet
                    },
                  ),
                  CustomDropdown(
                    label: '',
                    selectedItem: 'Hafta İçi',
                    items: profileOptions,
                    onChanged: (val) {
                      // TODO: Yük profili filtresini yönet
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // GRAFİK KARTI (Sadece beyaz arkaplan ve grafik)
        const DataChartCard(
          chartWidget: EChart(), // Placeholder Chart
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
