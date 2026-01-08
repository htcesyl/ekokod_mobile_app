import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_themes.dart';
import '../../../application/bills/bills_cubit.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/custom_dropdown.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/data_summary_card.dart';
import '../../shared_widgets/data_chart_card.dart';
import '../widgets/bills_chart.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  void initState() {
    super.initState();
    // Binaları ve faturaları yükle
    context.read<BillsCubit>().loadBuildings();
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Gradyanın görünmesi için şeffaf
        // Custom AppBar
        appBar: const CustomAppBar(weatherData: '21°C'),

        // Bottom Navigation Bar
        bottomNavigationBar: const MainBottomNavBar(
          selectedIndex: 2, // 'Faturalar' sayfasının indeksi
        ),

        // Sayfa İçeriği
        body: BlocBuilder<BillsCubit, BillsState>(
          builder: (context, state) {
            if (state is BillsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BillsError) {
              return Center(
                child: Text(
                  'Hata: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is BillsLoaded) {
              // Debug: State'teki verileri kontrol et
              print('🎨 UI Render: latestBill = ${state.latestBill != null ? "VAR (${state.latestBill!.totalCost.toStringAsFixed(2)} TL)" : "NULL"}');
              print('🎨 UI Render: billsChartData = ${state.billsChartData != null ? "VAR (${state.billsChartData!.length} nokta)" : "NULL"}');
              
              return SingleChildScrollView(
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
                          selectedItem: state.selectedBuilding?.name ?? 'Bina Seçiniz',
                          items: state.buildings.map((b) => b.name).toList(),
                          onChanged: (String? buildingName) {
                            if (buildingName != null) {
                              final building = state.buildings.firstWhere(
                                (b) => b.name == buildingName,
                              );
                              context.read<BillsCubit>().selectBuilding(building.id);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // ------------------------------------
                    // 2. Son Hesaplan Fatura (DataSummaryCard'lar)
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
                    _buildLatestBillCards(state.latestBill),
                    const SizedBox(height: 20),
                    // ------------------------------------
                    // 3. Faturalar - Son 12 Ay Grafiği
                    // ------------------------------------
                    const Text(
                      'Faturalar - Son 12 Ay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DataChartCard(
                      chartWidget: BillsChart(data: state.billsChartData),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }

            return const Center(child: Text('Veri yükleniyor...'));
          },
        ),
      ),
    );
  }

  /// Son hesaplan fatura kartlarını oluşturur
  Widget _buildLatestBillCards(bill) {
    if (bill == null) {
      return Row(
        children: [
          Expanded(
            child: DataSummaryCard(
              title: 'Tüketim',
              value: '-',
              isCurrency: false,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DataSummaryCard(
              title: 'Tutar',
              value: '-',
              isCurrency: false,
            ),
          ),
        ],
      );
    }

    // Tüketim değerini formatla (kWh)
    final consumption = bill.totalActiveKWh;
    final consumptionText = consumption > 0
        ? '${consumption.toStringAsFixed(2)} kWh'
        : '-';

    // Tutar değerini formatla (TL)
    final totalCost = bill.totalCost;
    final costText = totalCost > 0
        ? '₺ ${totalCost.toStringAsFixed(2)}'
        : '-';

    return Row(
      children: [
        Expanded(
          child: DataSummaryCard(
            title: 'Tüketim',
            value: consumptionText,
            isCurrency: false,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DataSummaryCard(
            title: 'Tutar',
            value: costText,
            isCurrency: false,
          ),
        ),
      ],
    );
  }
}
