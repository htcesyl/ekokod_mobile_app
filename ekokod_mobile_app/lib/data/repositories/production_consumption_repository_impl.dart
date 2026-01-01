// lib/data/repositories/production_consumption_repository_impl.dart
// Production-Consumption repository implementation
// Clean Architecture: Data layer - repository interface implementasyonu

import 'package:ekokod_mobile_app/domain/entities/daily_production_consumption_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_production_consumption_repository.dart';
import '../datasources/remote_production_consumption_datasource.dart';

class ProductionConsumptionRepositoryImpl
    implements IProductionConsumptionRepository {
  final RemoteProductionConsumptionDataSource remoteDataSource;

  ProductionConsumptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<DailyProductionConsumptionEntity?> getDailyProductionConsumption({
    required String date,
  }) async {
    try {
      final model = await remoteDataSource.getDailyProductionConsumption(
        date: date,
      );
      return model.toEntity();
    } catch (e) {
      // Hata durumunda null döndür (veya exception fırlatılabilir)
      return null;
    }
  }

  @override
  Future<DailyProductionConsumptionEntity?> getLatestProductionConsumption() async {
    try {
      final model = await remoteDataSource.getLatestProductionConsumption();
      return model.toEntity();
    } catch (e) {
      // 404 hatası = veri bulunamadı, bu normal bir durum
      final errorMessage = e.toString();
      if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
        print('ℹ️ Production-consumption verisi bulunamadı (404). Bu normal bir durum.');
        return null; // Veri yok, null döndür
      }
      // Diğer hatalar için exception fırlat
      print('❌ Production-consumption verisi çekilirken hata: $e');
      rethrow;
    }
  }

  @override
  Future<DailyProductionConsumptionEntity> createProductionConsumption({
    required String date,
    required double dailyConsumption,
    required double dailyProduction,
    String? buildingId,
    String? analyzerId,
  }) async {
    final model = await remoteDataSource.createProductionConsumption(
      date: date,
      dailyConsumption: dailyConsumption,
      dailyProduction: dailyProduction,
      buildingId: buildingId,
      analyzerId: analyzerId,
    );
    return model.toEntity();
  }
}
