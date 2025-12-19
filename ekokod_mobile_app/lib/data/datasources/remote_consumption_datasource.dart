import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';
import '../models/consumption_model.dart';

abstract class RemoteConsumptionDataSource {
  /// Tek analizör için tüketim verilerini getirir
  Future<ConsumptionResponseModel> getConsumption({
    required String analyzerId,
    required String period, // daily, monthly, yearly
    String? startDate, // YYYY-MM-DD
    String? endDate, // YYYY-MM-DD
    int? page,
    int? limit,
  });

  /// Birden fazla analizör için tüketim verilerini getirir
  Future<ConsumptionResponseModel> getConsumptions({
    required List<String> analyzerIds,
    required String period, // daily, monthly, yearly
    String? startDate, // YYYY-MM-DD
    String? endDate, // YYYY-MM-DD
    int? page,
    int? limit,
  });
}

class RemoteConsumptionDataSourceImpl implements RemoteConsumptionDataSource {
  final HttpClient httpClient;

  RemoteConsumptionDataSourceImpl(this.httpClient);

  @override
  Future<ConsumptionResponseModel> getConsumption({
    required String analyzerId,
    required String period,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, String>{
      'analyzer_id': analyzerId,
      'period': period,
    };

    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }
    if (page != null) {
      queryParams['page'] = page.toString();
    }
    if (limit != null) {
      queryParams['limit'] = limit.toString();
    }

    final json = await httpClient.get(
      ConsumptionEndpoints.list,
      queryParameters: queryParams,
    );

    return ConsumptionResponseModel.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<ConsumptionResponseModel> getConsumptions({
    required List<String> analyzerIds,
    required String period,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, String>{
      'analyzer_ids': analyzerIds.join(','),
      'period': period,
    };

    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }
    if (page != null) {
      queryParams['page'] = page.toString();
    }
    if (limit != null) {
      queryParams['limit'] = limit.toString();
    }

    final json = await httpClient.get(
      ConsumptionEndpoints.list,
      queryParameters: queryParams,
    );

    return ConsumptionResponseModel.fromJson(json as Map<String, dynamic>);
  }
}
