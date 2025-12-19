import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';
import '../models/analyzer_model.dart';

abstract class RemoteAnalyzerDataSource {
  Future<AnalyzerResponseModel> getAnalyzers({
    required String buildingId,
    bool excludeEnergyValues = true,
    bool excludeHourlyValues = true,
  });
}

class RemoteAnalyzerDataSourceImpl implements RemoteAnalyzerDataSource {
  final HttpClient httpClient;

  RemoteAnalyzerDataSourceImpl(this.httpClient);

  @override
  Future<AnalyzerResponseModel> getAnalyzers({
    required String buildingId,
    bool excludeEnergyValues = true,
    bool excludeHourlyValues = true,
  }) async {
    final json = await httpClient.get(
      AnalyzerEndpoints.list,
      queryParameters: {
        'buildingId': buildingId,
        'excludeEnergyValues': excludeEnergyValues.toString(),
        'excludeHourlyValues': excludeHourlyValues.toString(),
      },
    );

    return AnalyzerResponseModel.fromJson(json as Map<String, dynamic>);
  }
}
