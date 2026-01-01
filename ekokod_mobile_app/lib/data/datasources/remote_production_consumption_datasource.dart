// lib/data/datasources/remote_production_consumption_datasource.dart
// Backend API'den production-consumption verilerini çeken data source
// Clean Architecture: Data layer - API çağrıları

import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';
import '../models/daily_production_consumption_model.dart';

abstract class RemoteProductionConsumptionDataSource {
  /// Belirli bir tarih için günlük üretim ve tüketim verilerini getirir
  Future<DailyProductionConsumptionModel> getDailyProductionConsumption({
    required String date, // ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z"
  });

  /// En son eklenen günlük üretim ve tüketim verisini getirir
  Future<DailyProductionConsumptionModel> getLatestProductionConsumption();

  /// Yeni günlük üretim ve tüketim verisi ekler
  Future<DailyProductionConsumptionModel> createProductionConsumption({
    required String date,
    required double dailyConsumption,
    required double dailyProduction,
    String? buildingId,
    String? analyzerId,
  });
}

class RemoteProductionConsumptionDataSourceImpl
    implements RemoteProductionConsumptionDataSource {
  final HttpClient httpClient;

  RemoteProductionConsumptionDataSourceImpl(this.httpClient);

  @override
  Future<DailyProductionConsumptionModel> getDailyProductionConsumption({
    required String date,
  }) async {
    final queryParams = <String, String>{
      'date': date,
    };

    final json = await httpClient.get(
      ProductionConsumptionEndpoints.daily,
      queryParameters: queryParams,
    );

    return DailyProductionConsumptionModel.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<DailyProductionConsumptionModel> getLatestProductionConsumption() async {
    final json = await httpClient.get(
      ProductionConsumptionEndpoints.latest,
    );

    print('📥 Production-consumption latest response:');
    print('   Response: $json');
    
    // Backend'den gelen response'u kontrol et
    final responseMap = json as Map<String, dynamic>;
    
    // Backend 'id' döndürüyor ama model '_id' bekliyor, düzelt
    if (responseMap.containsKey('id') && !responseMap.containsKey('_id')) {
      responseMap['_id'] = responseMap['id'];
    }
    
    return DailyProductionConsumptionModel.fromJson(responseMap);
  }

  @override
  Future<DailyProductionConsumptionModel> createProductionConsumption({
    required String date,
    required double dailyConsumption,
    required double dailyProduction,
    String? buildingId,
    String? analyzerId,
  }) async {
    final body = <String, dynamic>{
      'date': date,
      'dailyConsumption': dailyConsumption,
      'dailyProduction': dailyProduction,
    };

    if (buildingId != null) {
      body['buildingId'] = buildingId;
    }
    if (analyzerId != null) {
      body['analyzerId'] = analyzerId;
    }

    final json = await httpClient.post(
      ProductionConsumptionEndpoints.create,
      body: body,
    );

    return DailyProductionConsumptionModel.fromJson(json as Map<String, dynamic>);
  }
}
