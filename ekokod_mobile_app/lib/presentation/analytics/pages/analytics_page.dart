import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/tab_selector.dart';
import '../../shared_widgets/period_selector.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/year_navigator.dart';
import '../../shared_widgets/data_chart_card.dart';
import '../widgets/consumption_tab_content.dart';
import '../widgets/production_tab_content.dart';
import '../widgets/carbon_footprint_tab_content.dart';
import '../../../core/constants/app_themes.dart';

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

  // Handle metotları...
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

  // Sekme içeriği oluşturma metodu...
  Widget _buildTabContent(AnalyticsTab tab) {
    switch (tab) {
      case AnalyticsTab.consumption:
        return ConsumptionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: _buildings,
          onBuildingChanged: _handleBuildingChange,
        );
      case AnalyticsTab.production:
        return ProductionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: _buildings,
          onBuildingChanged: _handleBuildingChange,
        );
      case AnalyticsTab.carbonFootprint:
        return CarbonFootprintTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: _buildings,
          onBuildingChanged: _handleBuildingChange,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // Ana Sayfa Yapısı
  @override
  Widget build(BuildContext context) {
    // YENİ EKLENEN: Gradyan Arkaplan Konteyneri
    return Container(
      decoration: const BoxDecoration(
        // analyticsBackgroundGradient sabitini kullanıyoruz
        gradient: secondBackgroundGradient,
      ),
      child: Scaffold(
        // Arkaplanı şeffaf yapıyoruz ki altındaki gradyan görünsün
        backgroundColor: Colors.transparent,

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
              // ÜST FİLTRE ALANI
              // ------------------------------------

              // 1. Tab Selector (Sekme Seçici)
              TabSelector(
                selectedTab: _selectedTab,
                onTabSelected: _handleTabChange, // Cubit'e bağlanacak
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Bina Seçimi
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
                          onChanged:
                              _handleBuildingChange, // Cubit'e bağlanacak
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // 3. Dönem Seçimi ve Yıl Navigasyonu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dönem Seçici (Gün/Hafta/Ay/Yıl)
                        PeriodSelector(
                          selectedPeriod: _selectedPeriod,
                          onPeriodSelected:
                              _handlePeriodChange, // Cubit'e bağlanacak
                        ),

                        // Yıl Gezgini
                        YearNavigator(
                          currentYear: _currentYear,
                          onPreviousYear:
                              () => _handleYearChange(isNext: false),
                          onNextYear: () => _handleYearChange(isNext: true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

              // ------------------------------------
              // SEKME İÇERİKLERİNİN GÖSTERİLDİĞİ ALAN
              // ------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                // Seçilen sekmeye göre ilgili içeriği yüklüyoruz.
                child: _buildTabContent(_selectedTab),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
