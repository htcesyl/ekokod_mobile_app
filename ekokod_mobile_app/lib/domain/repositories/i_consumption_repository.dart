import '../entities/chart_entity.dart';

abstract class IConsumptionRepository {
  /// Tek analizör için tüketim verilerini getirir
  Future<List<ChartPointEntity>> getConsumption({
    required String analyzerId,
    required String period, // daily, monthly, yearly
    String? startDate, // YYYY-MM-DD
    String? endDate, // YYYY-MM-DD
    int? page,
    int? limit,
  });

  /// Birden fazla analizör için tüketim verilerini getirir
  Future<Map<String, List<ChartPointEntity>>> getConsumptions({
    required List<String> analyzerIds,
    required String period, // daily, monthly, yearly
    String? startDate, // YYYY-MM-DD
    String? endDate, // YYYY-MM-DD
    int? page,
    int? limit,
  });
}
