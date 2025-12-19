import 'package:ekokod_mobile_app/domain/entities/analyzer_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_analyzer_repository.dart';
import '../datasources/remote_analyzer_datasource.dart';
import '../models/analyzer_model.dart';

class AnalyzerRepositoryImpl implements IAnalyzerRepository {
  final RemoteAnalyzerDataSource remoteDataSource;

  AnalyzerRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AnalyzerEntity>> getAnalyzers({
    required String buildingId,
    bool excludeEnergyValues = true,
    bool excludeHourlyValues = true,
  }) async {
    final response = await remoteDataSource.getAnalyzers(
      buildingId: buildingId,
      excludeEnergyValues: excludeEnergyValues,
      excludeHourlyValues: excludeHourlyValues,
    );
    return response.analyzers.map((model) => model.toEntity()).toList();
  }
}
