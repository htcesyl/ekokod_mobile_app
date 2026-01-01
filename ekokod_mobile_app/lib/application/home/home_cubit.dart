// lib/application/home/home_cubit.dart
// Home sayfası için state yönetimi
// Clean Architecture: Application layer - state management

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_production_consumption_entity.dart';
import '../../domain/entities/chart_entity.dart';
import '../../domain/repositories/i_building_repository.dart';
import '../../domain/repositories/i_analyzer_repository.dart';
import '../../domain/repositories/i_consumption_repository.dart';
import 'get_daily_production_consumption_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDailyProductionConsumptionUseCase getDailyProductionConsumptionUseCase;
  final IBuildingRepository buildingRepository;
  final IAnalyzerRepository analyzerRepository;
  final IConsumptionRepository consumptionRepository;

  HomeCubit({
    required this.getDailyProductionConsumptionUseCase,
    required this.buildingRepository,
    required this.analyzerRepository,
    required this.consumptionRepository,
  }) : super(const HomeInitial());

  /// Belirli bir tarih için günlük üretim ve tüketim verilerini yükler
  /// 
  /// [date] ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z"
  Future<void> loadDailyProductionConsumption({required String date}) async {
    emit(const HomeLoading());

    try {
      final data = await getDailyProductionConsumptionUseCase(date: date);
      
      if (data != null) {
        emit(HomeLoaded(data: data));
      } else {
        emit(const HomeError(message: 'Veri bulunamadı'));
      }
    } catch (e, st) {
      print('❌ Günlük üretim-tüketim verisi çekilirken hata: $e');
      print(st);
      emit(HomeError(message: e.toString()));
    }
  }

  /// En son eklenen günlük üretim ve tüketim verisini yükler
  Future<void> loadLatestProductionConsumption() async {
    emit(const HomeLoading());

    try {
      final data = await getDailyProductionConsumptionUseCase.getLatest();
      
      if (data != null) {
        // Yıllık tüketim verilerini de paralel olarak çek
        // Production-consumption verisindeki buildingId'yi kullan
        final annualData = await _loadAnnualConsumptionData(buildingId: data.buildingId);
        emit(HomeLoaded(data: data, annualConsumptionData: annualData));
      } else {
        // Veri yoksa, kullanıcıya daha anlamlı bir mesaj göster
        emit(const HomeError(message: 'Henüz üretim-tüketim verisi bulunmamaktadır'));
      }
    } catch (e, st) {
      print('❌ En son üretim-tüketim verisi çekilirken hata: $e');
      print(st);
      
      // 404 hatası için özel mesaj
      final errorMessage = e.toString();
      if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
        emit(const HomeError(message: 'Henüz üretim-tüketim verisi bulunmamaktadır'));
      } else {
        emit(HomeError(message: 'Veri yüklenirken bir hata oluştu: ${e.toString()}'));
      }
    }
  }

  /// Yıllık tüketim verilerini çeker (son 12 ay)
  /// Adımlar:
  /// 1. Belirtilen binanın analizörlerini çek (veya tüm binaları kontrol et)
  /// 2. Analizörlerin aylık tüketim verilerini çek (son 12 ay)
  Future<List<ChartPointEntity>?> _loadAnnualConsumptionData({String? buildingId}) async {
    try {
      print('📊 Yıllık tüketim verileri çekiliyor...');
      
      String finalBuildingId;
      
      // Eğer buildingId verilmediyse, binaları çek ve analizörü olan ilk binayı bul
      if (buildingId == null) {
        final buildings = await buildingRepository.getBuildings();
        if (buildings.isEmpty) {
          print('⚠️ Kullanıcının binası bulunamadı');
          return null;
        }
        
        // Analizörü olan ilk binayı bul
        String? foundBuildingId;
        for (final building in buildings) {
          final analyzers = await analyzerRepository.getAnalyzers(
            buildingId: building.id,
          );
          if (analyzers.isNotEmpty) {
            foundBuildingId = building.id;
            print('✅ Bina bulundu: ${building.name} (${building.id})');
            break;
          }
        }
        
        if (foundBuildingId == null) {
          print('⚠️ Analizörü olan bina bulunamadı');
          return null;
        }
        
        finalBuildingId = foundBuildingId;
      } else {
        print('✅ BuildingId kullanılıyor: $buildingId');
        finalBuildingId = buildingId;
      }
      
      // 2. Adım: Binanın analizörlerini çek
      final analyzers = await analyzerRepository.getAnalyzers(
        buildingId: finalBuildingId,
      );
      if (analyzers.isEmpty) {
        print('⚠️ Binada analizör bulunamadı (buildingId: $finalBuildingId)');
        return null;
      }
      
      final analyzerIds = analyzers.map((a) => a.id).toList();
      print('✅ ${analyzerIds.length} adet analizör bulundu');
      
      // 3. Adım: Son 12 ayın aylık tüketim verilerini çek
      final now = DateTime.now();
      final startDate = DateTime(now.year - 1, now.month, 1);
      final endDate = DateTime(now.year, now.month, now.day);
      
      final startDateStr = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
      final endDateStr = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
      
      print('📅 Tarih aralığı: $startDateStr - $endDateStr');
      
      // Birden fazla analizör için toplam tüketim verilerini çek
      final consumptionData = await consumptionRepository.getConsumptions(
        analyzerIds: analyzerIds,
        period: 'monthly',
        startDate: startDateStr,
        endDate: endDateStr,
        limit: 12,
      );
      
      if (consumptionData.isEmpty) {
        print('⚠️ Tüketim verisi bulunamadı');
        return null;
      }
      
      // Tüm analizörlerin verilerini topla (ay bazında)
      // Aynı ay için farklı analizörlerin verilerini birleştir
      final Map<String, double> monthlyTotals = {};
      final Map<String, DateTime> monthlyTimestamps = {};
      
      for (final analyzerId in analyzerIds) {
        final analyzerData = consumptionData[analyzerId];
        if (analyzerData != null) {
          for (final point in analyzerData) {
            // Aylık veriler için ay/yıl anahtarı oluştur (örn: "10/2025")
            final monthKey = _extractMonthKey(point.timestamp);
            monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0.0) + point.value;
            // Timestamp'i de sakla (ilk gelen verinin timestamp'ini kullan)
            if (!monthlyTimestamps.containsKey(monthKey)) {
              monthlyTimestamps[monthKey] = point.timestamp;
            }
          }
        }
      }
      
      // ChartPointEntity listesine dönüştür
      final chartPoints = monthlyTotals.entries.map((entry) {
        final timestamp = monthlyTimestamps[entry.key] ?? DateTime.now();
        return ChartPointEntity(timestamp: timestamp, value: entry.value);
      }).toList();
      
      // Tarihe göre sırala
      chartPoints.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      print('✅ ${chartPoints.length} adet aylık tüketim verisi hazırlandı');
      return chartPoints;
      
    } catch (e, st) {
      print('❌ Yıllık tüketim verileri çekilirken hata: $e');
      print(st);
      // Hata olsa bile ana veri yüklenmeye devam etsin
      return null;
    }
  }

  /// DateTime'dan ay/yıl anahtarı oluşturur (örn: "10/2025")
  /// Aynı ay için farklı analizörlerin verilerini birleştirmek için kullanılır
  String _extractMonthKey(DateTime date) {
    return '${date.month}/${date.year}';
  }

  /// Verileri yeniler (en son veriyi çeker)
  Future<void> refresh() async {
    await loadLatestProductionConsumption();
  }
}
