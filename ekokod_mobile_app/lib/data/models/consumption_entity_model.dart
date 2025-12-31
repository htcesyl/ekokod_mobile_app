// lib/data/models/consumption_entity_model.dart
// ConsumptionEntity için data model
// Clean Architecture: Data layer - JSON serialization ve entity dönüşümü

import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/consumption_entity.dart';
import 'consumption_model.dart';

part 'consumption_entity_model.g.dart';

@JsonSerializable()
class ConsumptionEntityModel {
  final String periodLabel;
  final double activeConsumption;
  final double indConsumption;
  final double capConsumption;
  final double indRate;
  final double capRate;
  final double t1Consumption;
  final double t2Consumption;
  final double t3Consumption;
  final double activeIndex;
  final double indIndex;
  final double capIndex;

  ConsumptionEntityModel({
    required this.periodLabel,
    required this.activeConsumption,
    required this.indConsumption,
    required this.capConsumption,
    required this.indRate,
    required this.capRate,
    required this.t1Consumption,
    required this.t2Consumption,
    required this.t3Consumption,
    required this.activeIndex,
    required this.indIndex,
    required this.capIndex,
  });

  /// JSON'dan model oluşturur
  factory ConsumptionEntityModel.fromJson(Map<String, dynamic> json) =>
      _$ConsumptionEntityModelFromJson(json);

  /// Model'i JSON'a çevirir
  Map<String, dynamic> toJson() => _$ConsumptionEntityModelToJson(this);

  /// ConsumptionPointModel'den ConsumptionEntityModel oluşturur
  /// (Mevcut API response modelinden dönüşüm)
  factory ConsumptionEntityModel.fromConsumptionPointModel(
    ConsumptionPointModel point,
  ) {
    return ConsumptionEntityModel(
      periodLabel: point.periodLabel,
      activeConsumption: point.activeConsumption,
      indConsumption: point.indConsumption,
      capConsumption: point.capConsumption,
      indRate: point.indRate,
      capRate: point.capRate,
      t1Consumption: point.t1Consumption,
      t2Consumption: point.t2Consumption,
      t3Consumption: point.t3Consumption,
      activeIndex: point.activeIndex,
      indIndex: point.indIndex,
      capIndex: point.capIndex,
    );
  }

  /// Entity'den model oluşturur
  factory ConsumptionEntityModel.fromEntity(ConsumptionEntity entity) {
    return ConsumptionEntityModel(
      periodLabel: entity.periodLabel,
      activeConsumption: entity.activeConsumption,
      indConsumption: entity.indConsumption,
      capConsumption: entity.capConsumption,
      indRate: entity.indRate,
      capRate: entity.capRate,
      t1Consumption: entity.t1Consumption,
      t2Consumption: entity.t2Consumption,
      t3Consumption: entity.t3Consumption,
      activeIndex: entity.activeIndex,
      indIndex: entity.indIndex,
      capIndex: entity.capIndex,
    );
  }

  /// Model'i ConsumptionEntity'ye dönüştürür
  ConsumptionEntity toEntity() {
    final timestamp = ConsumptionEntity.parsePeriodLabel(periodLabel) ?? DateTime.now();
    
    return ConsumptionEntity(
      periodLabel: periodLabel,
      timestamp: timestamp,
      activeConsumption: activeConsumption,
      indConsumption: indConsumption,
      capConsumption: capConsumption,
      indRate: indRate,
      capRate: capRate,
      t1Consumption: t1Consumption,
      t2Consumption: t2Consumption,
      t3Consumption: t3Consumption,
      activeIndex: activeIndex,
      indIndex: indIndex,
      capIndex: capIndex,
    );
  }
}

// Extension: ConsumptionPointModel'den direkt entity'ye dönüşüm
extension ConsumptionPointModelToEntityExtension on ConsumptionPointModel {
  /// ConsumptionPointModel'den direkt ConsumptionEntity'ye dönüşüm
  ConsumptionEntity toConsumptionEntity() {
    final timestamp = ConsumptionEntity.parsePeriodLabel(periodLabel) ?? DateTime.now();
    
    return ConsumptionEntity(
      periodLabel: periodLabel,
      timestamp: timestamp,
      activeConsumption: activeConsumption,
      indConsumption: indConsumption,
      capConsumption: capConsumption,
      indRate: indRate,
      capRate: capRate,
      t1Consumption: t1Consumption,
      t2Consumption: t2Consumption,
      t3Consumption: t3Consumption,
      activeIndex: activeIndex,
      indIndex: indIndex,
      capIndex: capIndex,
    );
  }
}
