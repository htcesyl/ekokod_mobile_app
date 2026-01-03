import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/shared/enums.dart';
import '../../shared_widgets/tab_selector.dart';
import '../../shared_widgets/period_selector.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/year_navigator.dart';
import '../../shared_widgets/month_navigator.dart';
import '../../shared_widgets/day_navigator.dart';
import '../widgets/consumption_tab_content.dart';
import '../widgets/production_tab_content.dart';
import '../widgets/carbon_footprint_tab_content.dart';
import '../../../core/constants/app_themes.dart';
import '../../../application/analytics/analytics_cubit.dart';
import '../../../injections/injection_container.dart' as di;

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
  int _currentMonth = DateTime.now().month; // 1-12 arası
  DateTime _currentDay = DateTime.now(); // Seçili gün

  @override
  void initState() {
    super.initState();
    // Başlangıçta Tüketim sekmesinin ilk filtresini seçiyoruz.
    // Tüketim sekmesi için Cubit'ten gelecek, diğerleri için hardcoded
    if (_selectedTab == AnalyticsTab.consumption) {
      // Cubit yüklendikten sonra ayarlanacak
      _selectedBuilding = 'Bina 1'; // Geçici değer
    } else {
      _selectedBuilding = _availableFilters[_selectedTab]!.first;
    }
  }
  
  void _initializeData(BuildContext context) {
    final cubit = context.read<AnalyticsCubit>();
    cubit.loadBuildings().then((_) {
      if (_selectedTab == AnalyticsTab.consumption) {
        cubit.loadConsumptionData(
          buildingName: _selectedBuilding,
          period: _selectedPeriod,
          year: _currentYear,
          month: _currentMonth,
          day: _selectedPeriod == PeriodType.day ? _currentDay : null,
        );
      }
    });
  }

  // Dinamik olarak değişecek filtre listeleri (Mock Veri)
  final Map<AnalyticsTab, List<String>> _availableFilters = {
    // Tüketim için Bina listesi - Sadece Bina 1 ve Bina 2
    AnalyticsTab.consumption: ['Bina 1', 'Bina 2'],
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
    }
  }

  // Seçili sekmeye göre mevcut filtre listesini döndürür
  // Tüketim sekmesi için Cubit'ten gelen binaları kullanır
  List<String> _getCurrentBuildingList(AnalyticsState? state) {
    if (_selectedTab == AnalyticsTab.consumption) {
      // Tüketim sekmesi için Cubit'ten gelen binaları kullan
      if (state is AnalyticsLoaded) {
        final buildings = state.buildingNameToId.keys.toList();
        if (buildings.isNotEmpty) {
          return buildings;
        }
      }
      // Henüz yüklenmemişse boş liste döndür
      return [];
    }
    // Diğer sekmeler için hardcoded listeyi kullan
    return _availableFilters[_selectedTab] ?? [];
  }

  // Handle metotları...
  // Bu metodlar BlocBuilder içindeki context ile çağrılmalı
  void _handleTabChange(AnalyticsTab tab, BuildContext blocContext) {
    setState(() {
      _selectedTab = tab;
      if (tab == AnalyticsTab.consumption) {
        // Tüketim sekmesi için Cubit state'inden al
        final cubit = blocContext.read<AnalyticsCubit>();
        final currentState = cubit.state;
        if (currentState is AnalyticsLoaded) {
          final buildings = currentState.buildingNameToId.keys.toList();
          if (buildings.isNotEmpty) {
            _selectedBuilding = buildings.first;
          }
        }
      } else {
        final newFilterList = _availableFilters[tab] ?? [];
        if (newFilterList.isNotEmpty) {
          _selectedBuilding = newFilterList.first;
        }
      }
    });
    
    // Tüketim sekmesindeyse veri çek
    if (tab == AnalyticsTab.consumption) {
      blocContext.read<AnalyticsCubit>().loadConsumptionData(
        buildingName: _selectedBuilding,
        period: _selectedPeriod,
        year: _currentYear,
      );
    }
  }

  void _handlePeriodChange(PeriodType period, BuildContext blocContext) async {
    // Eğer "Gün" seçiliyorsa ve zaten seçili değilse, önce period'u değiştir
    // Eğer zaten "Gün" seçiliyse, tarih seçici aç
    if (period == PeriodType.day) {
      if (_selectedPeriod == PeriodType.day) {
        // Zaten "Gün" seçili, tarih seçici aç
        final selectedDate = await showDatePicker(
          context: blocContext,
          initialDate: _currentDay,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          locale: const Locale('tr', 'TR'),
          helpText: 'Hangi günü seçmek istersiniz?',
          cancelText: 'İptal',
          confirmText: 'Seç',
        );
        
        if (selectedDate != null) {
          setState(() {
            _currentDay = selectedDate;
          });
          
          // Tüketim sekmesindeyse veri çek
          if (_selectedTab == AnalyticsTab.consumption) {
            blocContext.read<AnalyticsCubit>().loadConsumptionData(
              buildingName: _selectedBuilding,
              period: period,
              year: _currentYear,
              day: _currentDay,
            );
          }
        }
        return; // Period değiştirme işlemini yapma
      } else {
        // "Gün" seçili değil, önce period'u değiştir, sonra tarih seçici aç
        setState(() {
          _selectedPeriod = period;
          _currentDay = DateTime.now();
        });
        
        // Tarih seçici aç
        final selectedDate = await showDatePicker(
          context: blocContext,
          initialDate: _currentDay,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          locale: const Locale('tr', 'TR'),
          helpText: 'Hangi günü seçmek istersiniz?',
          cancelText: 'İptal',
          confirmText: 'Seç',
        );
        
        if (selectedDate != null) {
          setState(() {
            _currentDay = selectedDate;
          });
        }
        
        // Tüketim sekmesindeyse veri çek
        if (_selectedTab == AnalyticsTab.consumption) {
          blocContext.read<AnalyticsCubit>().loadConsumptionData(
            buildingName: _selectedBuilding,
            period: period,
            year: _currentYear,
            day: _currentDay,
          );
        }
        return;
      }
    }
    
    // Diğer period'lar için normal işlem
    setState(() {
      _selectedPeriod = period;
      // Period değiştiğinde ay'ı bugünün ayına sıfırla (eğer ay seçildiyse)
      if (period == PeriodType.month) {
        _currentMonth = DateTime.now().month;
      }
    });
    
    // Tüketim sekmesindeyse veri çek
    if (_selectedTab == AnalyticsTab.consumption) {
      blocContext.read<AnalyticsCubit>().loadConsumptionData(
        buildingName: _selectedBuilding,
        period: period,
        year: _currentYear,
        month: period == PeriodType.month ? _currentMonth : null,
      );
    }
  }

  void _handleBuildingChange(String? building, BuildContext blocContext) {
    if (building != null) {
      setState(() {
        _selectedBuilding = building;
      });
      
      // Tüketim sekmesindeyse veri çek
      if (_selectedTab == AnalyticsTab.consumption) {
        blocContext.read<AnalyticsCubit>().loadConsumptionData(
          buildingName: building,
          period: _selectedPeriod,
          year: _currentYear,
          month: _selectedPeriod == PeriodType.month ? _currentMonth : null,
          day: _selectedPeriod == PeriodType.day ? _currentDay : null,
        );
      }
    }
  }

  void _handleYearChange({required bool isNext, required BuildContext blocContext}) {
    setState(() {
      _currentYear += isNext ? 1 : -1;
    });
    
    // Tüketim sekmesindeyse veri çek
    if (_selectedTab == AnalyticsTab.consumption) {
      blocContext.read<AnalyticsCubit>().loadConsumptionData(
        buildingName: _selectedBuilding,
        period: _selectedPeriod,
        year: _currentYear,
        month: _currentMonth,
      );
    }
  }

  void _handleMonthChange({required bool isNext, required BuildContext blocContext}) {
    setState(() {
      if (isNext) {
        _currentMonth++;
        if (_currentMonth > 12) {
          _currentMonth = 1;
          _currentYear++;
        }
      } else {
        _currentMonth--;
        if (_currentMonth < 1) {
          _currentMonth = 12;
          _currentYear--;
        }
      }
    });
    
    // Tüketim sekmesindeyse veri çek
    if (_selectedTab == AnalyticsTab.consumption) {
      blocContext.read<AnalyticsCubit>().loadConsumptionData(
        buildingName: _selectedBuilding,
        period: _selectedPeriod,
        year: _currentYear,
        month: _currentMonth,
      );
    }
  }

  void _handleDayChange({required bool isNext, required BuildContext blocContext}) {
    setState(() {
      if (isNext) {
        _currentDay = _currentDay.add(const Duration(days: 1));
      } else {
        _currentDay = _currentDay.subtract(const Duration(days: 1));
      }
    });
    
    // Tüketim sekmesindeyse veri çek
    if (_selectedTab == AnalyticsTab.consumption) {
      blocContext.read<AnalyticsCubit>().loadConsumptionData(
        buildingName: _selectedBuilding,
        period: _selectedPeriod,
        year: _currentYear,
        day: _currentDay,
      );
    }
  }

  // Sekme içeriği oluşturma metodu...
  Widget _buildTabContent(AnalyticsTab tab, AnalyticsState? state, BuildContext blocContext) {
    final list = _getCurrentBuildingList(state);
    
    // Building change callback'i context ile sarmala
    final onBuildingChanged = (String? building) => _handleBuildingChange(building, blocContext);

    switch (tab) {
      case AnalyticsTab.consumption:
        return ConsumptionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: onBuildingChanged,
        );
      case AnalyticsTab.production:
        return ProductionTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: onBuildingChanged,
        );
      case AnalyticsTab.carbonFootprint:
        return CarbonFootprintTabContent(
          selectedPeriod: _selectedPeriod,
          selectedBuilding: _selectedBuilding,
          availableBuildings: list,
          onBuildingChanged: onBuildingChanged,
        );
    }
  }

  // Ana Sayfa Yapısı
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyticsCubit>(
      create: (_) => di.sl<AnalyticsCubit>(),
      child: Container(
        decoration: const BoxDecoration(gradient: secondBackgroundGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(
            weatherData: '21°C', // Mock Hava Durumu
          ),

          bottomNavigationBar: const MainBottomNavBar(
            selectedIndex: 1, // 'Veri Analizi' sayfasının indeksi
          ),

          body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              // İlk yüklemede veri çek
              if (state is AnalyticsInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _initializeData(context);
                });
              }
              
              // Binalar yüklendiğinde seçili binayı güncelle
              if (state is AnalyticsLoaded && _selectedTab == AnalyticsTab.consumption) {
                final buildings = state.buildingNameToId.keys.toList();
                if (buildings.isNotEmpty && !buildings.contains(_selectedBuilding)) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedBuilding = buildings.first;
                    });
                    context.read<AnalyticsCubit>().loadConsumptionData(
                      buildingName: _selectedBuilding,
                      period: _selectedPeriod,
                      year: _currentYear,
                      month: _selectedPeriod == PeriodType.month ? _currentMonth : null,
                      day: _selectedPeriod == PeriodType.day ? _currentDay : null,
                    );
                  });
                }
              }
              
              return SingleChildScrollView(
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
                onTabSelected: (tab) => _handleTabChange(tab, context),
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
                        BlocBuilder<AnalyticsCubit, AnalyticsState>(
                          builder: (context, state) {
                            final buildingList = _getCurrentBuildingList(state);
                            
                            // Eğer seçili bina listede yoksa, ilk binayı seç
                            String selectedBuilding = _selectedBuilding;
                            if (!buildingList.contains(selectedBuilding) && buildingList.isNotEmpty) {
                              selectedBuilding = buildingList.first;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  _selectedBuilding = selectedBuilding;
                                });
                              });
                            }
                            
                            if (buildingList.isEmpty) {
                              return const Text('Bina yükleniyor...');
                            }
                            
                            return CustomDropdown(
                              label: '',
                              selectedItem: selectedBuilding,
                              items: buildingList,
                              onChanged: (building) => _handleBuildingChange(building, context),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // 3. Dönem Seçimi ve Yıl/Ay Navigasyonu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dönem Seçici (Gün/Hafta/Ay/Yıl)
                        PeriodSelector(
                          selectedPeriod: _selectedPeriod,
                          onPeriodSelected: (period) => _handlePeriodChange(period, context),
                        ),

                        // Period'a göre Yıl, Ay veya Gün Navigatörü göster
                        Flexible(
                          child: _selectedPeriod == PeriodType.day
                              ? DayNavigator(
                                  currentDay: _currentDay,
                                  onPreviousDay: () => _handleDayChange(isNext: false, blocContext: context),
                                  onNextDay: () => _handleDayChange(isNext: true, blocContext: context),
                                )
                              : _selectedPeriod == PeriodType.month
                                  ? MonthNavigator(
                                      currentMonth: _currentMonth,
                                      onPreviousMonth: () => _handleMonthChange(isNext: false, blocContext: context),
                                      onNextMonth: () => _handleMonthChange(isNext: true, blocContext: context),
                                    )
                                  : YearNavigator(
                                      currentYear: _currentYear,
                                      onPreviousYear: () => _handleYearChange(isNext: false, blocContext: context),
                                      onNextYear: () => _handleYearChange(isNext: true, blocContext: context),
                                    ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildTabContent(_selectedTab, state, context),
                ),
              ],
            ),
          );
            },
          ),
        ),
      ),
    );
  }
}
