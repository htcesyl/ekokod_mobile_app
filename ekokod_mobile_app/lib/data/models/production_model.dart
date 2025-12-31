// lib/data/models/production_model.dart
// ProductionEntity için data model
// Clean Architecture: Data layer - JSON serialization ve entity dönüşümü

import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/production_entity.dart';
import 'consumption_model.dart';

part 'production_model.g.dart';

@JsonSerializable()
class ProductionModel {
  final String periodLabel;
  final double activeGeneration;
  final double indGeneration;
  final double capGeneration;
  final double activeGenerationIndex;
  final double indGenerationIndex;
  final double capGenerationIndex;

  ProductionModel({
    required this.periodLabel,
    required this.activeGeneration,
    required this.indGeneration,
    required this.capGeneration,
    required this.activeGenerationIndex,
    required this.indGenerationIndex,
    required this.capGenerationIndex,
  });

  /// JSON'dan model oluşturur
  factory ProductionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionModelFromJson(json);

  /// Model'i JSON'a çevirir
  Map<String, dynamic> toJson() => _$ProductionModelToJson(this);

  /// ConsumptionPointModel'den ProductionModel oluşturur
  /// (Mevcut API response modelinden üretim verilerini çıkarır)
  factory ProductionModel.fromConsumptionPointModel(
    ConsumptionPointModel point,
  ) {
    return ProductionModel(
      periodLabel: point.periodLabel,
      activeGeneration: point.activeGeneration,
      indGeneration: point.indGeneration,
      capGeneration: point.capGeneration,
      activeGenerationIndex: point.activeGenerationIndex,
      indGenerationIndex: point.indGenerationIndex,
      capGenerationIndex: point.capGenerationIndex,
    );
  }

  /// Entity'den model oluşturur
  factory ProductionModel.fromEntity(ProductionEntity entity) {
    return ProductionModel(
      periodLabel: entity.periodLabel,
      activeGeneration: entity.activeGeneration,
      indGeneration: entity.indGeneration,
      capGeneration: entity.capGeneration,
      activeGenerationIndex: entity.activeGenerationIndex,
      indGenerationIndex: entity.indGenerationIndex,
      capGenerationIndex: entity.capGenerationIndex,
    );
  }

  /// Model'i ProductionEntity'ye dönüştürür
  ProductionEntity toEntity() {
    final timestamp = ProductionEntity.parsePeriodLabel(periodLabel) ?? DateTime.now();
    
    return ProductionEntity(
      periodLabel: periodLabel,
      timestamp: timestamp,
      activeGeneration: activeGeneration,
      indGeneration: indGeneration,
      capGeneration: capGeneration,
      activeGenerationIndex: activeGenerationIndex,
      indGenerationIndex: indGenerationIndex,
      capGenerationIndex: capGenerationIndex,
    );
  }
}

// Extension: ConsumptionPointModel'den direkt ProductionEntity'ye dönüşüm
extension ConsumptionPointModelToProductionEntityExtension on ConsumptionPointModel {
  /// ConsumptionPointModel'den direkt ProductionEntity'ye dönüşüm
  ProductionEntity toProductionEntity() {
    final timestamp = ProductionEntity.parsePeriodLabel(periodLabel) ?? DateTime.now();
    
    return ProductionEntity(
      periodLabel: periodLabel,
      timestamp: timestamp,
      activeGeneration: activeGeneration,
      indGeneration: indGeneration,
      capGeneration: capGeneration,
      activeGenerationIndex: activeGenerationIndex,
      indGenerationIndex: indGenerationIndex,
      capGenerationIndex: capGenerationIndex,
    );
  }
}
