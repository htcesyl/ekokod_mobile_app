import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/data_summary_card.dart';
import '../../shared_widgets/data_chart_card.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  // Mock Filtre Değişkenleri (Cubit entegrasyonundan sonra Cubit State'inden alınacak)
  String _selectedBuilding = 'Bina 1';
  final List<String> _buildings = ['Bina 1', 'Bina 2', 'Tüm Binalar'];
  String _selectedPeriodForChart = 'Hafta İçi';
  final List<String> _chartPeriodOptions = [
    'Hafta İçi',
    'Hafta Sonu',
    'Ay',
    'Yıl',
  ];

  void _handleBuildingChange(String? building) {
    if (building != null) {
      setState(() {
        _selectedBuilding = building;
      });
    }
  }

  void _handleChartPeriodChange(String? period) {
    if (period != null) {
      setState(() {
        _selectedPeriodForChart = period;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Gradyanın görünmesi için şeffaf
        // Custom AppBar
        appBar: const CustomAppBar(
          pageTitle: 'Faturalar',
          weatherData: '21°C', // Mock Hava Durumu
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: const MainBottomNavBar(
          selectedIndex: 2, // 'Faturalar' sayfasının indeksi
        ),

        // Sayfa İçeriği
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------
              // 1. Bina Seçimi Filtresi
              // ------------------------------------
              Row(
                children: [
                  const Text('Bina Seçiniz', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 10),
                  CustomDropdown(
                    label: '',
                    selectedItem: _selectedBuilding,
                    items: _buildings,
                    onChanged: _handleBuildingChange,
                  ),
                ],
              ),
              const SizedBox(height: 20), // Boşluk
              // ------------------------------------
              // 2. Son Hesaplan Faturalar (DataSummaryCard'lar)
              // ------------------------------------
              const Text(
                'Son Hesaplan Fatura',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Tüketim Kartı
                  Expanded(
                    child: DataSummaryCard(
                      title: 'Tüketim',
                      value: '3.240 kWh',
                      isCurrency: false, // Varsayılan renk
                    ),
                  ),
                  const SizedBox(width: 10), // Kartlar arası boşluk
                  // Tutar Kartı
                  Expanded(
                    child: DataSummaryCard(
                      title: 'Tutar',
                      value: '₺ 12.480',
                      isCurrency: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Boşluk
              // ------------------------------------
              // 3. Faturalar - Bu Yıl Grafiği
              // ------------------------------------

              // GRAFİK BAŞLIĞI VE FİLTRESİ (DOĞRUDAN ROW KULLANIMI)
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sol Başlık
                    const Text(
                      'Faturalar - Bu yıl',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    // Sağ Filtre (Dropdown)
                    CustomDropdown(
                      label: '',
                      selectedItem: _selectedPeriodForChart,
                      items: _chartPeriodOptions,
                      onChanged: _handleChartPeriodChange,
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
          ),
        ),
      ),
    );
  }
}
