import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';

class ProductionTabContent extends StatelessWidget {
  // AnalizPage'den (üst Cubit katmanından) gelen filtreler
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

  // Başlık ve Filtreyi Grafiğin Üzerine Konumlandıran Yardımcı Widget
  // Bu yapı, başlık ve filtrelerin beyaz kartın dışında kalmasını sağlar.
  Widget _buildHeaderRow({
    required String title,
    required Widget filterWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol Başlık
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
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
    // Üretim profili seçenekleri için mock data
    final List<String> profileOptions = ['24 Saat', '48 Saat', 'Tüm Günler'];

    return Column(
      children: [
        // ----------------------------------------
        // 1. Üretim Grafiği Kartı (Bar Chart)
        // ----------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - FİGMA UYUMLU)
        _buildHeaderRow(
          title: 'Üretim - Bu ${selectedPeriod.name}',
          filterWidget: CustomDropdown(
            label: '',
            selectedItem: selectedBuilding,
            items: availableBuildings,
            onChanged: onBuildingChanged,
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

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA - FİGMA UYUMLU)
        _buildHeaderRow(
          title: 'Günlük Üretim Profili',
          filterWidget: CustomDropdown(
            label: '', // Bu Dropdown'ın içinde etiket var
            selectedItem: '24 Saat',
            items: profileOptions,
            onChanged: (val) {
              // TODO: Profil filtresini yönet
            },
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
