// lib/application/analytics/analytics_cubit.dart
// Analytics sayfası için state yönetimi
// Clean Architecture: Application layer - state management

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/chart_entity.dart';
import '../../domain/shared/enums.dart';
import '../../domain/repositories/i_building_repository.dart';
import '../../domain/repositories/i_analyzer_repository.dart';
import '../../domain/repositories/i_consumption_repository.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final IBuildingRepository buildingRepository;
  final IAnalyzerRepository analyzerRepository;
  final IConsumptionRepository consumptionRepository;

  AnalyticsCubit({
    required this.buildingRepository,
    required this.analyzerRepository,
    required this.consumptionRepository,
  }) : super(const AnalyticsInitial());

  /// Binaları yükler ve "Bina 1", "Bina 2" ile eşleştirir
  /// Sadece analizörü olan binaları seçer
  Future<void> loadBuildings() async {
    try {
      final buildings = await buildingRepository.getBuildings();
      
      if (buildings.isEmpty) {
        emit(const AnalyticsError(message: 'Bina bulunamadı'));
        return;
      }

      // Analizörü olan binaları bul
      final Map<String, String> buildingNameToId = {};
      int buildingIndex = 0;
      
      for (final building in buildings) {
        try {
          final analyzers = await analyzerRepository.getAnalyzers(
            buildingId: building.id,
          );
          
          if (analyzers.isNotEmpty) {
            // Analizörü olan ilk binayı "Bina 1" olarak işaretle
            if (buildingIndex == 0) {
              buildingNameToId['Bina 1'] = building.id;
              print('✅ Bina 1 eşleştirildi: ${building.name} (${building.id})');
              buildingIndex++;
            } 
            // Analizörü olan ikinci binayı "Bina 2" olarak işaretle
            else if (buildingIndex == 1) {
              buildingNameToId['Bina 2'] = building.id;
              print('✅ Bina 2 eşleştirildi: ${building.name} (${building.id})');
              buildingIndex++;
              break; // İki bina yeterli
            }
          }
        } catch (e) {
          print('⚠️ Bina ${building.id} için analizör kontrolü başarısız: $e');
          // Devam et, diğer binaları kontrol et
        }
      }

      if (buildingNameToId.isEmpty) {
        emit(const AnalyticsError(message: 'Analizörü olan bina bulunamadı'));
        return;
      }

      emit(AnalyticsLoaded(
        buildingNameToId: buildingNameToId,
        selectedPeriod: null,
      ));
    } catch (e, st) {
      print('❌ Binalar yüklenirken hata: $e');
      print(st);
      emit(AnalyticsError(message: e.toString()));
    }
  }

  /// Seçilen binaya göre tüketim verilerini yükler
  Future<void> loadConsumptionData({
    required String buildingName, // "Bina 1" veya "Bina 2"
    required PeriodType period,
    required int year,
    int? month, // Ay seçimi için (1-12), sadece PeriodType.month için kullanılır
    DateTime? day, // Gün seçimi için, sadece PeriodType.day için kullanılır
  }) async {
    emit(const AnalyticsLoading());

    try {
      // Mevcut state'den building mapping'i al
      final currentState = state;
      if (currentState is! AnalyticsLoaded) {
        // Önce binaları yükle
        await loadBuildings();
        final newState = state;
        if (newState is! AnalyticsLoaded) {
          emit(const AnalyticsError(message: 'Bina bilgileri yüklenemedi'));
          return;
        }
      }

      final loadedState = state as AnalyticsLoaded;
      final buildingNameToId = loadedState.buildingNameToId;
      
      if (buildingNameToId.isEmpty) {
        emit(const AnalyticsError(message: 'Bina bilgileri yüklenemedi'));
        return;
      }
      
      final buildingId = buildingNameToId[buildingName];

      if (buildingId == null) {
        // Eğer seçilen bina yoksa, mevcut binalardan birini kullan
        final availableBuildings = buildingNameToId.keys.toList();
        if (availableBuildings.isEmpty) {
          emit(const AnalyticsError(message: 'Kullanılabilir bina bulunamadı'));
          return;
        }
        
        // İlk mevcut binayı kullan
        final fallbackBuilding = availableBuildings.first;
        final fallbackId = buildingNameToId[fallbackBuilding]!;
        print('⚠️ $buildingName bulunamadı, $fallbackBuilding kullanılıyor');
        
        // Fallback building ile devam et
        await _loadConsumptionDataForBuilding(
          buildingId: fallbackId,
          buildingName: fallbackBuilding,
          period: period,
          year: year,
          month: month,
          day: day,
          buildingNameToId: buildingNameToId,
        );
        return;
      }
      
      await _loadConsumptionDataForBuilding(
        buildingId: buildingId,
        buildingName: buildingName,
        period: period,
        year: year,
        month: month,
        day: day,
        buildingNameToId: buildingNameToId,
      );
    } catch (e, st) {
      print('❌ Tüketim verileri çekilirken hata: $e');
      print(st);
      emit(AnalyticsError(message: e.toString()));
    }
  }
  
  /// Belirli bir bina için tüketim verilerini yükler (internal helper method)
  Future<void> _loadConsumptionDataForBuilding({
    required String buildingId,
    required String buildingName,
    required PeriodType period,
    required int year,
    int? month,
    DateTime? day,
    required Map<String, String> buildingNameToId,
  }) async {

      print('📊 Tüketim verileri çekiliyor: Bina=$buildingName, ID=$buildingId, Period=$period, Year=$year, Month=$month, Day=$day');

      // 1. Binanın analizörlerini çek
      final analyzers = await analyzerRepository.getAnalyzers(
        buildingId: buildingId,
      );

      if (analyzers.isEmpty) {
        print('⚠️ Binada analizör bulunamadı: $buildingName ($buildingId)');
        emit(AnalyticsLoaded(
          buildingNameToId: buildingNameToId,
          consumptionData: [],
          selectedPeriod: period,
        ));
        return;
      }

      final analyzerIds = analyzers.map((a) => a.id).toList();
      print('✅ ${analyzerIds.length} adet analizör bulundu');

      // 2. Period'a göre tarih aralığını belirle
      final now = DateTime.now();
      DateTime startDate;
      DateTime endDate;
      String periodStr;

      switch (period) {
        case PeriodType.day:
          // Gün: Seçilen günün tarihi
          // Eğer seçilen gün için veri yoksa, son 30 günün verisini çek
          // Böylece en azından bir veri bulma şansımız artar
          final selectedDay = day ?? DateTime(now.year, now.month, now.day);
          final targetDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          // Son 30 günün verisini çek (seçilen gün dahil)
          startDate = targetDate.subtract(const Duration(days: 29));
          endDate = targetDate;
          periodStr = 'daily';
          break;
        case PeriodType.week:
          // Hafta: Seçili yılda bugünün haftasının başlangıcı (Pazartesi)
          final today = DateTime(year, now.month, now.day);
          final daysFromMonday = (today.weekday - 1) % 7;
          startDate = today.subtract(Duration(days: daysFromMonday));
          endDate = startDate.add(const Duration(days: 6));
          periodStr = 'daily';
          break;
        case PeriodType.month:
          // Ay: Seçili yıl ve ayda seçilen ayın tamamı
          final selectedMonth = month ?? now.month;
          startDate = DateTime(year, selectedMonth, 1);
          endDate = DateTime(year, selectedMonth + 1, 0); // Ayın son günü
          periodStr = 'daily';
          break;
        case PeriodType.year:
          // Yıl: Seçili yılın tamamı (aylık veriler)
          startDate = DateTime(year, 1, 1);
          endDate = DateTime(year, 12, 31);
          periodStr = 'monthly';
          break;
      }

      final startDateStr = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
      final endDateStr = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

      print('📅 Tarih aralığı: $startDateStr - $endDateStr');

      // 3. Tüketim verilerini çek
      final consumptionData = await consumptionRepository.getConsumptions(
        analyzerIds: analyzerIds,
        period: periodStr,
        startDate: startDateStr,
        endDate: endDateStr,
      );

      print('📦 API\'den gelen veri: ${consumptionData.length} analizör');
      for (final entry in consumptionData.entries) {
        print('  - Analizör ${entry.key}: ${entry.value.length} veri noktası');
        if (entry.value.isNotEmpty) {
          print('    İlk veri: ${entry.value.first.timestamp}, değer: ${entry.value.first.value}');
        }
      }

      // 4. Verileri birleştir ve dönüştür
      List<ChartPointEntity> chartPoints = [];

      if (consumptionData.isNotEmpty) {
        // Tüm analizörlerin verilerini topla
        final Map<String, double> totals = {};
        final Map<String, DateTime> timestamps = {};

        for (final analyzerId in analyzerIds) {
          final analyzerData = consumptionData[analyzerId];
          if (analyzerData != null) {
            for (final point in analyzerData) {
              // Period'a göre key oluştur
              String key;
              switch (period) {
                case PeriodType.year:
                  // Yıllık: Aylık veriler için ay/yıl anahtarı
                  key = '${point.timestamp.month}/${point.timestamp.year}';
                  break;
                case PeriodType.month:
                  // Aylık: Günlük veriler için tarih anahtarı
                  key = '${point.timestamp.year}-${point.timestamp.month.toString().padLeft(2, '0')}-${point.timestamp.day.toString().padLeft(2, '0')}';
                  break;
                case PeriodType.week:
                  // Haftalık: Günlük veriler için tarih anahtarı
                  key = '${point.timestamp.year}-${point.timestamp.month.toString().padLeft(2, '0')}-${point.timestamp.day.toString().padLeft(2, '0')}';
                  break;
                case PeriodType.day:
                  // Günlük: Saatlik veriler için saat anahtarı (eğer saatlik veri varsa)
                  // Şimdilik günlük toplam olarak göster
                  key = '${point.timestamp.year}-${point.timestamp.month.toString().padLeft(2, '0')}-${point.timestamp.day.toString().padLeft(2, '0')}';
                  break;
              }

              totals[key] = (totals[key] ?? 0.0) + point.value;
              if (!timestamps.containsKey(key)) {
                timestamps[key] = point.timestamp;
              }
            }
          }
        }

        // ChartPointEntity listesine dönüştür
        chartPoints = totals.entries.map((entry) {
          final timestamp = timestamps[entry.key] ?? DateTime.now();
          return ChartPointEntity(timestamp: timestamp, value: entry.value);
        }).toList();

        // Tarihe göre sırala
        chartPoints.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        
        // Günlük veri için: Seçilen günün verisini bul, yoksa en son veri olan günü göster
        if (period == PeriodType.day && chartPoints.isNotEmpty) {
          final selectedDay = day ?? DateTime(now.year, now.month, now.day);
          final targetDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          
          // Seçilen günün verisini bul
          final selectedDayData = chartPoints.where((point) {
            final pointDate = DateTime(point.timestamp.year, point.timestamp.month, point.timestamp.day);
            return pointDate == targetDate;
          }).toList();
          
          if (selectedDayData.isNotEmpty) {
            // Seçilen gün için veri varsa, sadece o günün verisini göster
            chartPoints = selectedDayData;
            print('✅ Seçilen gün (${targetDate.toString().split(' ')[0]}) için veri bulundu');
          } else {
            // Seçilen gün için veri yoksa, en son veri olan günü göster
            chartPoints = [chartPoints.last];
            final lastDataDate = DateTime(
              chartPoints.first.timestamp.year,
              chartPoints.first.timestamp.month,
              chartPoints.first.timestamp.day,
            );
            print('⚠️ Seçilen gün (${targetDate.toString().split(' ')[0]}) için veri yok, en son veri olan gün gösteriliyor: ${lastDataDate.toString().split(' ')[0]}');
          }
        }
      } else {
        print('⚠️ API\'den veri gelmedi veya boş döndü');
      }

      print('✅ ${chartPoints.length} adet veri noktası oluşturuldu (Period: $period)');
      if (chartPoints.isNotEmpty) {
        print('  İlk veri: ${chartPoints.first.timestamp}, değer: ${chartPoints.first.value}');
        print('  Son veri: ${chartPoints.last.timestamp}, değer: ${chartPoints.last.value}');
      }

      emit(AnalyticsLoaded(
        buildingNameToId: buildingNameToId,
        consumptionData: chartPoints,
        selectedPeriod: period,
      ));
  }
}
