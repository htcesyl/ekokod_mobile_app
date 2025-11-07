import 'package:flutter/material.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/data_chart_card.dart';
import '../../shared_widgets/data_summary_card.dart';
import '../../../core/constants/app_themes.dart';

class CarbonFootprintTabContent extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth / 2) - 26;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------
        // 1. KARBON AYAK İZİ METRİK KARTLARI
        // ------------------------------------
        // Metrik kartlarının kendi başlıkları olduğu için ayrı bir Row başlığa gerek yok.
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              SizedBox(
                width: cardWidth,
                height: 120,
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

        // BAŞLIK VE FİLTRE
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sol Başlık
              Text(
                'CO2 Salınım Analizi - Bu ${selectedPeriod.name}',
                style: const TextStyle(
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

        const SizedBox(height: 10),
      ],
    );
  }
}
