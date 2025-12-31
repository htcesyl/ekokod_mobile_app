// lib/application/home/get_daily_production_consumption_usecase.dart
// Günlük üretim-tüketim verilerini getiren use case
// Clean Architecture: Application layer - business logic

import '../../domain/entities/daily_production_consumption_entity.dart';
import '../../domain/repositories/i_production_consumption_repository.dart';

class GetDailyProductionConsumptionUseCase {
  final IProductionConsumptionRepository repository;

  GetDailyProductionConsumptionUseCase(this.repository);

  /// Belirli bir tarih için günlük üretim ve tüketim verilerini getirir
  /// 
  /// [date] ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z"
  Future<DailyProductionConsumptionEntity?> call({
    required String date,
  }) {
    return repository.getDailyProductionConsumption(date: date);
  }

  /// En son eklenen günlük üretim ve tüketim verisini getirir
  Future<DailyProductionConsumptionEntity?> getLatest() {
    return repository.getLatestProductionConsumption();
  }
}
