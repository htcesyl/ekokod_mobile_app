import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_themes.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/tab_selector.dart';
import '../../shared_widgets/period_selector.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/year_navigator.dart';
import '../../shared_widgets/data_chart_card.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  // Cubit'ten gelecek state'i yönetmek için placeholder değişkenler
  AnalyticsTab _selectedTab = AnalyticsTab.consumption;
  PeriodType _selectedPeriod = PeriodType.year;
  String _selectedBuilding = 'Bina 1';
  int _currentYear = 2025;

  // Bina listesi (Mock veri)
  final List<String> _buildings = ['Bina 1', 'Bina 2', 'Tüm Binalar'];

  // Not: Cubit bağlandıktan sonra bu metotlar Cubit'e çağrı yapacaktır.
  void _handleTabChange(AnalyticsTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  void _handlePeriodChange(PeriodType period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  void _handleBuildingChange(String? building) {
    if (building != null) {
      setState(() {
        _selectedBuilding = building;
      });
    }
  }

  void _handleYearChange({required bool isNext}) {
    setState(() {
      _currentYear += isNext ? 1 : -1;
    });
  }

  // Tüketim Sekmesi İçeriğini oluşturan özel metot
  Widget _buildConsumptionContent() {
    final List<String> profileOptions = [
      'Hafta İçi',
      'Hafta Sonu',
      'Tüm Günler',
    ];

    return Column(
      children: [
        // 1. Tüketim Grafiği Kartı
        DataChartCard(
          title: 'Tüketim - ${_selectedPeriod.name}',
          // Sağ üstte Bina Seçimi Dropdown'ı
          rightHeaderWidget: CustomDropdown(
            label: '',
            selectedItem: _selectedBuilding,
            items: _buildings,
            onChanged: _handleBuildingChange,
          ),
          chartWidget: const MockChart(), // Placeholder Chart
        ),

        // 2. Yük Profili Grafiği Kartı
        DataChartCard(
          title: 'Yük Profili',
          // Sağ üstte Yük Profili Seçimi Dropdown'ı
          rightHeaderWidget: CustomDropdown(
            label: '',
            selectedItem: 'Hafta İçi',
            items: profileOptions,
            onChanged: (val) {
              // Yük profili filtresini yönet
            },
          ),
          chartWidget: const MockChart(), // Placeholder Chart
        ),

        const SizedBox(height: 10), // Sayfa alt boşluğu
      ],
    );
  }

  // Ana Sayfa Yapısı
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom App Bar (AppBar olarak kullanmak için PreferredSizeWidget implementasyonu)
      appBar: const CustomAppBar(
        pageTitle: 'Veri Analizi',
        weatherData: '21°C', // Mock Hava Durumu
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const MainBottomNavBar(
        selectedIndex: 1, // 'Veri Analizi' sayfasının indeksi
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------
            // SEKME SEÇİM ALANI
            // ------------------------------------

            // Sekme Seçici (Tüketim/Üretim/Karbon Ayak İzi)
            TabSelector(
              selectedTab: _selectedTab,
              onTabSelected: _handleTabChange,
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Bina Seçimi
                  Row(
                    children: [
                      const Text(
                        'Bina Seçiniz',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                      CustomDropdown(
                        label: '',
                        selectedItem: _selectedBuilding,
                        items: _buildings,
                        onChanged: _handleBuildingChange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // 2. Dönem Seçimi ve Yıl Navigasyonu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dönem Seçici (Gün/Hafta/Ay/Yıl)
                      PeriodSelector(
                        selectedPeriod: _selectedPeriod,
                        onPeriodSelected: _handlePeriodChange,
                      ),

                      // Yıl Gezgini
                      YearNavigator(
                        currentYear: _currentYear,
                        onPreviousYear: () => _handleYearChange(isNext: false),
                        onNextYear: () => _handleYearChange(isNext: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),

            // ------------------------------------
            // SEKME İÇERİĞİ
            // ------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Builder(
                builder: (context) {
                  // Mevcut sekmeye göre içeriği göster
                  switch (_selectedTab) {
                    case AnalyticsTab.consumption:
                      return _buildConsumptionContent();
                    case AnalyticsTab.production:
                      return const Center(
                        child: Text('Üretim Analizi Gelecek'),
                      );
                    case AnalyticsTab.carbonFootprint:
                      return const Center(
                        child: Text('Karbon Ayak İzi Analizi Gelecek'),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
