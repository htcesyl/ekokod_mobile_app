// lib/domain/repositories/i_production_consumption_repository.dart
// Production-Consumption verileri için repository interface
// Clean Architecture: Domain layer - framework bağımlılığı yok

import '../entities/daily_production_consumption_entity.dart';

abstract class IProductionConsumptionRepository {
  /// Belirli bir tarih için günlük üretim ve tüketim verilerini getirir
  /// 
  /// [date] ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z"
  Future<DailyProductionConsumptionEntity?> getDailyProductionConsumption({
    required String date,
  });

  /// En son eklenen günlük üretim ve tüketim verisini getirir
  Future<DailyProductionConsumptionEntity?> getLatestProductionConsumption();

  /// Yeni günlük üretim ve tüketim verisi ekler
  Future<DailyProductionConsumptionEntity> createProductionConsumption({
    required String date,
    required double dailyConsumption,
    required double dailyProduction,
    String? buildingId,
    String? analyzerId,
  });
}
