import '../entities/analyzer_entity.dart';

abstract class IAnalyzerRepository {
  Future<List<AnalyzerEntity>> getAnalyzers({
    required String buildingId,
    bool excludeEnergyValues = true,
    bool excludeHourlyValues = true,
  });
}
