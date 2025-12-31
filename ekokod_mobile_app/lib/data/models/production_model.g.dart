// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionModel _$ProductionModelFromJson(Map<String, dynamic> json) =>
    ProductionModel(
      periodLabel: json['periodLabel'] as String,
      activeGeneration: (json['activeGeneration'] as num).toDouble(),
      indGeneration: (json['indGeneration'] as num).toDouble(),
      capGeneration: (json['capGeneration'] as num).toDouble(),
      activeGenerationIndex: (json['activeGenerationIndex'] as num).toDouble(),
      indGenerationIndex: (json['indGenerationIndex'] as num).toDouble(),
      capGenerationIndex: (json['capGenerationIndex'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductionModelToJson(ProductionModel instance) =>
    <String, dynamic>{
      'periodLabel': instance.periodLabel,
      'activeGeneration': instance.activeGeneration,
      'indGeneration': instance.indGeneration,
      'capGeneration': instance.capGeneration,
      'activeGenerationIndex': instance.activeGenerationIndex,
      'indGenerationIndex': instance.indGenerationIndex,
      'capGenerationIndex': instance.capGenerationIndex,
    };
