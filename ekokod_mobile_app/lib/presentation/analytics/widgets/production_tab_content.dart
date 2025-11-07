import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../../core/constants/app_themes.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';

class ProductionTabContent extends StatelessWidget {
  final PeriodType selectedPeriod;
  final String selectedBuilding;
  final List<String> availableBuildings;
  final ValueChanged<String?> onBuildingChanged;

  const ProductionTabContent({
    super.key,
    required this.selectedPeriod,
    required this.selectedBuilding,
    required this.availableBuildings,
    required this.onBuildingChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Üretim profili seçenekleri için mock data
    final List<String> profileOptions = ['24 Saat', '48 Saat', 'Tüm Günler'];
    final List<String> seasonOptions = ['İlkbahar', 'Yaz', 'Sonbahar', 'Kış'];

    return Column(
      children: [
        // ----------------------------------------
        // 1. Üretim Grafiği Kartı (Bar Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - DOĞRUDAN ROW KULLANIMI)
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sol Başlık
              const Text(
                'Üretim', // Başlık
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
        const DataChartCard(
          chartWidget: EChart(), // Placeholder Chart
        ),

        const SizedBox(height: 15),

        // ----------------------------------------
        // 2. Günlük Üretim Profili (Line Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - DOĞRUDAN ROW KULLANIMI)
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sol Başlık
              const Text(
                'Günlük Üretim Profili',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),

              const Spacer(),
              // Sağ Filtre
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
                    selectedItem: '24 Saat',
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
