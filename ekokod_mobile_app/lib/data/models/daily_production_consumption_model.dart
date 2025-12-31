// lib/data/models/daily_production_consumption_model.dart
// MongoDB için günlük üretim-tüketim veri modeli
// Clean Architecture: Data layer - JSON serialization ve entity dönüşümü

import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/daily_production_consumption_entity.dart';

part 'daily_production_consumption_model.g.dart';

@JsonSerializable()
class DailyProductionConsumptionModel {
  @JsonKey(name: '_id')
  final String id;
  
  @JsonKey(name: 'date')
  final DateTime date;
  
  final double dailyConsumption;
  final double dailyProduction;
  final double netConsumption;
  final String? buildingId;
  final String? analyzerId;
  
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  DailyProductionConsumptionModel({
    required this.id,
    required this.date,
    required this.dailyConsumption,
    required this.dailyProduction,
    required this.netConsumption,
    this.buildingId,
    this.analyzerId,
    this.createdAt,
    this.updatedAt,
  });

  /// JSON'dan model oluşturur (MongoDB document'inden)
  factory DailyProductionConsumptionModel.fromJson(Map<String, dynamic> json) =>
      _$DailyProductionConsumptionModelFromJson(json);

  /// Model'i JSON'a çevirir (MongoDB'ye yazmak için)
  Map<String, dynamic> toJson() => _$DailyProductionConsumptionModelToJson(this);

  /// Entity'den model oluşturur
  factory DailyProductionConsumptionModel.fromEntity(
    DailyProductionConsumptionEntity entity, {
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final netConsumption = DailyProductionConsumptionEntity.calculateNetConsumption(
      entity.dailyConsumption,
      entity.dailyProduction,
    );

    return DailyProductionConsumptionModel(
      id: id ?? entity.date.toIso8601String(),
      date: entity.date,
      dailyConsumption: entity.dailyConsumption,
      dailyProduction: entity.dailyProduction,
      netConsumption: netConsumption,
      buildingId: entity.buildingId,
      analyzerId: entity.analyzerId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Model'i DailyProductionConsumptionEntity'ye dönüştürür
  DailyProductionConsumptionEntity toEntity() {
    return DailyProductionConsumptionEntity(
      date: date,
      dailyConsumption: dailyConsumption,
      dailyProduction: dailyProduction,
      netConsumption: netConsumption,
      buildingId: buildingId,
      analyzerId: analyzerId,
    );
  }

  /// ConsumptionEntity ve ProductionEntity'den model oluşturur
  /// (API'den gelen verileri birleştirir)
  factory DailyProductionConsumptionModel.fromConsumptionAndProduction({
    required DateTime date,
    required double consumption,
    required double production,
    String? buildingId,
    String? analyzerId,
    String? id,
  }) {
    final netConsumption = DailyProductionConsumptionEntity.calculateNetConsumption(
      consumption,
      production,
    );

    return DailyProductionConsumptionModel(
      id: id ?? date.toIso8601String(),
      date: date,
      dailyConsumption: consumption,
      dailyProduction: production,
      netConsumption: netConsumption,
      buildingId: buildingId,
      analyzerId: analyzerId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
