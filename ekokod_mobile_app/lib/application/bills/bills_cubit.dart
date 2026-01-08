// lib/application/bills/bills_cubit.dart
// Bills sayfası için state yönetimi
// Clean Architecture: Application layer - state management

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/building_entity.dart';
import '../../domain/entities/bill_history_entity.dart';
import '../../domain/entities/chart_entity.dart';
import '../../domain/repositories/i_building_repository.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  final IBuildingRepository buildingRepository;

  BillsCubit({
    required this.buildingRepository,
  }) : super(const BillsInitial());

  /// Binaları yükler ve ilk binayı seçer
  Future<void> loadBuildings() async {
    emit(const BillsLoading());

    try {
      final buildings = await buildingRepository.getBuildings();

      if (buildings.isEmpty) {
        emit(const BillsError(message: 'Bina bulunamadı'));
        return;
      }

      // İlk binayı seç ve faturalarını yükle
      final selectedBuilding = buildings.first;
      await loadBillsForBuilding(selectedBuilding.id);

      // loadBillsForBuilding zaten state'i güncelledi (BillsLoaded emit etti)
      // Eğer state hala BillsLoaded değilse (ki olmamalı), o zaman emit edelim
      final currentState = state;
      if (currentState is BillsLoaded) {
        // State zaten güncellenmiş, buildings listesini güncelle
        emit(currentState.copyWith(
          buildings: buildings,
        ));
      } else {
        // Bu durum teorik olarak olmamalı ama güvenlik için
        emit(BillsLoaded(
          buildings: buildings,
          selectedBuilding: selectedBuilding,
        ));
      }
    } catch (e) {
      print('❌ Binalar yüklenirken hata: $e');
      emit(BillsError(message: e.toString()));
    }
  }

  /// Belirli bir bina için faturaları yükler
  Future<void> loadBillsForBuilding(String buildingId) async {
    try {
      final buildings = await buildingRepository.getBuildings();
      final building = buildings.firstWhere(
        (b) => b.id == buildingId,
        orElse: () => buildings.first,
      );

      print('🔍 Bina kontrol ediliyor: ${building.name}');
      print('🔍 billHistory null mu? ${building.billHistory == null}');
      if (building.billHistory != null) {
        print('🔍 billHistory uzunluğu: ${building.billHistory!.length}');
        print('🔍 billHistory keys: ${building.billHistory!.keys.toList()}');
      }

      if (building.billHistory == null || building.billHistory!.isEmpty) {
        print('⚠️ Bina için fatura geçmişi bulunamadı: ${building.name}');
        print('⚠️ billHistory null: ${building.billHistory == null}');
        print('⚠️ billHistory empty: ${building.billHistory?.isEmpty ?? true}');
        final currentState = state;
        if (currentState is BillsLoaded) {
          emit(currentState.copyWith(
            selectedBuilding: building,
            latestBill: null,
            billsChartData: null,
          ));
        }
        return;
      }

      // En son faturayı al (monthKey'ler sıralı olarak alınır, en yeni önce)
      BillHistoryItemEntity? latestBill;
      if (building.billHistory != null && building.billHistory!.isNotEmpty) {
        final keys = building.billHistory!.keys.toList();
        keys.sort((a, b) => b.compareTo(a)); // En yeni önce (descending)
        latestBill = building.billHistory![keys.first];
        if (latestBill != null) {
          print('📄 En son fatura bulundu: ${keys.first}, Tutar: ${latestBill.totalCost.toStringAsFixed(2)} TL, Tüketim: ${latestBill.totalActiveKWh.toStringAsFixed(2)} kWh');
        } else {
          print('⚠️ En son fatura bulunamadı (latestBill null)');
        }
      } else {
        print('⚠️ En son fatura bulunamadı (billHistory boş)');
      }

      // Son 12 ayın fatura verilerini hazırla (grafik için)
      final billsChartData = _prepareBillsChartData(building.billHistory);
      
      print('📊 Grafik verisi hazırlandı: ${billsChartData?.length ?? 0} nokta');
      if (billsChartData != null && billsChartData.isNotEmpty) {
        print('📊 İlk grafik noktası: ${billsChartData.first.timestamp}, değer: ${billsChartData.first.value}');
        print('📊 Son grafik noktası: ${billsChartData.last.timestamp}, değer: ${billsChartData.last.value}');
      }

      final currentState = state;
      if (currentState is BillsLoaded) {
        emit(currentState.copyWith(
          selectedBuilding: building,
          latestBill: latestBill,
          billsChartData: billsChartData,
        ));
      } else {
        emit(BillsLoaded(
          buildings: buildings,
          selectedBuilding: building,
          latestBill: latestBill,
          billsChartData: billsChartData,
        ));
      }
    } catch (e) {
      print('❌ Faturalar yüklenirken hata: $e');
      final currentState = state;
      if (currentState is BillsLoaded) {
        emit(currentState.copyWith(
          latestBill: null,
          billsChartData: null,
        ));
      }
    }
  }

  /// Bina seçimini değiştirir
  void selectBuilding(String buildingId) {
    loadBillsForBuilding(buildingId);
  }

  /// Son 12 ayın fatura verilerini ChartPointEntity listesine çevirir
  List<ChartPointEntity>? _prepareBillsChartData(
    Map<String, BillHistoryItemEntity>? billHistory,
  ) {
    if (billHistory == null || billHistory.isEmpty) {
      return null;
    }

    // Bill history'deki tüm monthKey'leri al ve sırala (en yeni önce)
    final allMonthKeys = billHistory.keys.toList();
    allMonthKeys.sort((a, b) => b.compareTo(a)); // Descending: 2025-12, 2025-11, ...
    
    // Son 12 ayı al (eğer 12'den fazla varsa)
    final last12MonthKeys = allMonthKeys.take(12).toList();
    last12MonthKeys.sort((a, b) => a.compareTo(b)); // Grafik için ascending: 2025-01, 2025-02, ...
    
    print('📅 Bill history\'den ${allMonthKeys.length} ay bulundu');
    print('📅 Son 12 ay seçildi: ${last12MonthKeys.join(", ")}');

    // Bill history'den son 12 ayın verilerini al
    final List<ChartPointEntity> chartData = [];
    
    for (final monthKey in last12MonthKeys) {
      final bill = billHistory[monthKey];
      if (bill != null) {
        // MonthKey'den DateTime oluştur (ayın ilk günü)
        final dateParts = monthKey.split('-');
        final year = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final timestamp = DateTime(year, month, 1);
        
        chartData.add(ChartPointEntity(
          timestamp: timestamp,
          value: bill.totalCost,
        ));
        print('  ✅ $monthKey: ${bill.totalCost.toStringAsFixed(2)} TL');
      } else {
        // Bu durum teorik olarak olmamalı çünkü last12MonthKeys billHistory'den geliyor
        // Ama yine de güvenlik için ekliyoruz
        final dateParts = monthKey.split('-');
        final year = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final timestamp = DateTime(year, month, 1);
        
        chartData.add(ChartPointEntity(
          timestamp: timestamp,
          value: 0,
        ));
        print('  ⚠️ $monthKey: Veri yok (0)');
      }
    }
    
    print('✅ ${chartData.length} adet grafik noktası oluşturuldu');

    return chartData;
  }
}
