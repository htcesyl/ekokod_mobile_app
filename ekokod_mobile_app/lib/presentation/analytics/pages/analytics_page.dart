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
  late String _selectedBuilding;
  int _currentYear = 2025;

  @override
  void initState() {
    super.initState();
    // Başlangıçta Tüketim sekmesinin ilk filtresini seçiyoruz.
    _selectedBuilding = _availableFilters[_selectedTab]!.first;
  }

  // Dinamik olarak değişecek filtre listeleri (Mock Veri)
  final Map<AnalyticsTab, List<String>> _availableFilters = {
    // Tüketim için Bina listesi
    AnalyticsTab.consumption: ['Bina 1', 'Bina 2', 'Tüm Binalar'],
    // Üretim için Santral listesi
    AnalyticsTab.production: ['Santral A', 'Santral B'],
    // Karbon Ayak İzi için tüm binalar (veya daha genel bir seçenek)
    AnalyticsTab.carbonFootprint: ['Tüm Binalar'],
  };

  // Seçili Sekmeye göre etiket metnini döndürür
  String get _buildingSelectorLabel {
    switch (_selectedTab) {
      case AnalyticsTab.consumption:
        return 'Bina Seçiniz';
      case AnalyticsTab.production:
        return 'Santral Seçiniz';
      case AnalyticsTab.carbonFootprint:
        return 'Seçiniz'; // Veya genel bir etiket
      default:
        return 'Bina Seçiniz';
    }
  }

  // Seçili sekmeye göre mevcut filtre listesini döndürür
  List<String> get _currentBuildingList {
    return _availableFilters[_selectedTab] ?? ['Bina 1'];
  }

  // Handle metotları...
  void _handleTabChange(AnalyticsTab tab) {
    setState(() {
      _selectedTab = tab;
      final newFilterList = _availableFilters[tab] ?? ['Bina 1'];
      if (newFilterList.isNotEmpty) {
        _selectedBuilding = newFilterList.first;
      }
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
    final list = _currentBuildingList;

    switch (tab) {
      case AnalyticsTab.consumption:
        return ConsumptionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: _handleBuildingChange,
        );
      case AnalyticsTab.production:
        return ProductionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: _handleBuildingChange,
        );
      case AnalyticsTab.carbonFootprint:
        return CarbonFootprintTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: _handleBuildingChange,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // Ana Sayfa Yapısı
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          weatherData: '21°C', // Mock Hava Durumu
        ),

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
                    // 2. Bina veya Santral Seçimi
                    Row(
                      children: [
                        Text(
                          _buildingSelectorLabel,
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                        CustomDropdown(
                          label: '',
                          selectedItem: _selectedBuilding,
                          items: _currentBuildingList,
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTabContent(_selectedTab),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
