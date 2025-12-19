import 'package:ekokod_mobile_app/domain/entities/chart_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_consumption_repository.dart';
import '../datasources/remote_consumption_datasource.dart';
import '../models/consumption_model.dart';

class ConsumptionRepositoryImpl implements IConsumptionRepository {
  final RemoteConsumptionDataSource remoteDataSource;

  ConsumptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ChartPointEntity>> getConsumption({
    required String analyzerId,
    required String period,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
  }) async {
    final response = await remoteDataSource.getConsumption(
      analyzerId: analyzerId,
      period: period,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    if (response.consumption != null) {
      return response.consumption!
          .map((point) => point.toEntity())
          .toList();
    }

    return [];
  }

  @override
  Future<Map<String, List<ChartPointEntity>>> getConsumptions({
    required List<String> analyzerIds,
    required String period,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
  }) async {
    final response = await remoteDataSource.getConsumptions(
      analyzerIds: analyzerIds,
      period: period,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    if (response.consumptions != null) {
      return response.consumptions!.map(
        (analyzerId, points) => MapEntry(
          analyzerId,
          points.map((point) => point.toEntity()).toList(),
        ),
      );
    }

    return {};
  }
}
