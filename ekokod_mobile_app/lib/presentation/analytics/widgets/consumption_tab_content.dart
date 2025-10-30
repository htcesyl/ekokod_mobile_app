import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';

class ConsumptionTabContent extends StatelessWidget {
  // AnalizPage'den (üst katman) gelen filtreler ve callback'ler
  final PeriodType selectedPeriod;
  final String selectedBuilding;
  final List<String> availableBuildings;
  final ValueChanged<String?> onBuildingChanged;

  // NOT: Gerçek veriler Cubit'ten gelecek ve burada ChartEntity olarak kullanılacaktır.

  const ConsumptionTabContent({
    super.key,
    required this.selectedPeriod,
    required this.selectedBuilding,
    required this.availableBuildings,
    required this.onBuildingChanged,
  });

  Widget _buildHeaderRow({
    required String title,
    required Widget filterWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol Başlık
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          // Sağ Filtre (Dropdown)
          filterWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Yük Profili Dropdown'ı için mock data
    final List<String> profileOptions = [
      'Hafta İçi',
      'Hafta Sonu',
      'Tüm Günler',
    ];

    return Column(
      children: [
        // ----------------------------------------
        // 1. Tüketim Grafiği (Bar Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - FİGMA UYUMLU)
        _buildHeaderRow(
          title: 'Tüketim - Bu ${selectedPeriod.name}',
          filterWidget: CustomDropdown(
            label: '',
            selectedItem: selectedBuilding,
            items: availableBuildings,
            onChanged: onBuildingChanged,
          ),
        ),

        // GRAFİK KARTI (Sadece beyaz arkaplan ve grafik)
        const DataChartCard(chartWidget: EChart()),

        const SizedBox(height: 10),

        // ----------------------------------------
        // 2. Yük Profili Grafiği (Line Chart)
        // ----------------------------------------
        _buildHeaderRow(
          title: 'Yük Profili',
          filterWidget: CustomDropdown(
            label: '',
            selectedItem: 'Hafta İçi',
            items: profileOptions,
            onChanged: (val) {
              // TODO: Yük profili filtresini yönet
            },
          ),
        ),

        // GRAFİK KARTI (Sadece beyaz arkaplan ve grafik)
        const DataChartCard(chartWidget: EChart()),

        const SizedBox(height: 10),
      ],
    );
  }
}
