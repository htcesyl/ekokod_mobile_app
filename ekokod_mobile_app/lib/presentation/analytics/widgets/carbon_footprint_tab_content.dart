import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';
import '../../shared_widgets/data_summary_card.dart';
import '../../../core/constants/app_themes.dart';

class CarbonFootprintTabContent extends StatelessWidget {
  // AnalizPage'den (üst Cubit katmanından) gelen filtreler
  final PeriodType selectedPeriod;
  final String selectedBuilding;
  final List<String> availableBuildings;
  final ValueChanged<String?> onBuildingChanged;

  const CarbonFootprintTabContent({
    super.key,
    required this.selectedPeriod,
    required this.selectedBuilding,
    required this.availableBuildings,
    required this.onBuildingChanged,
  });

  // Başlık ve Filtreyi Grafiğin Üzerine Konumlandıran Yardımcı Widget
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
              color: AppColors.black,
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
    final screenWidth = MediaQuery.of(context).size.width;
    // 2'li grid düzeninde kart genişliği hesaplaması
    final cardWidth = (screenWidth / 2) - 26;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------
        // 1. KARBON AYAK İZİ METRİK KARTLARI (Filtre veya Başlık Yok)
        // ------------------------------------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 10.0, // Yatay boşluk
            runSpacing: 10.0, // Dikey boşluk
            children: [
              // Metrik Kartları
              SizedBox(
                width: cardWidth,
                height: 120, // Sabit yükseklik, görsel tutarlılık için
                child: const DataSummaryCard(
                  title: 'Yıllık Elektrik Tüketimi',
                  value: '124.000 kWh/yıl',
                  isCurrency: false,
                ),
              ),

              SizedBox(
                width: cardWidth,
                height: 120,
                child: const DataSummaryCard(
                  title: 'Yıllık Karbon Emisyonu',
                  value: '52.1 ton/yıl',
                  isCurrency: false,
                ),
              ),
              // ... diğer iki kart da buraya eklenebilir ...
              SizedBox(
                width: cardWidth,
                height: 120,
                child: const DataSummaryCard(
                  title: 'Kişi Başı Karbon',
                  value: '1.2 ton/yıl-kişi',
                  isCurrency: false,
                ),
              ),
              SizedBox(
                width: cardWidth,
                height: 120,
                child: const DataSummaryCard(
                  title: 'Birim Alan Karbon',
                  value: '0.0008 ton/yıl-m2',
                  isCurrency: false,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // ------------------------------------
        // 2. KARBON AYAK İZİ GRAFİĞİ
        // ------------------------------------

        // BAŞLIK VE FİLTRE (KARTIN DIŞINDA)
        _buildHeaderRow(
          title: 'CO2 Salınım Analizi - Bu ${selectedPeriod.name}',
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

        const SizedBox(height: 10),
      ],
    );
  }
}
