// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_entity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumptionEntityModel _$ConsumptionEntityModelFromJson(
  Map<String, dynamic> json,
) => ConsumptionEntityModel(
  periodLabel: json['periodLabel'] as String,
  activeConsumption: (json['activeConsumption'] as num).toDouble(),
  indConsumption: (json['indConsumption'] as num).toDouble(),
  capConsumption: (json['capConsumption'] as num).toDouble(),
  indRate: (json['indRate'] as num).toDouble(),
  capRate: (json['capRate'] as num).toDouble(),
  t1Consumption: (json['t1Consumption'] as num).toDouble(),
  t2Consumption: (json['t2Consumption'] as num).toDouble(),
  t3Consumption: (json['t3Consumption'] as num).toDouble(),
  activeIndex: (json['activeIndex'] as num).toDouble(),
  indIndex: (json['indIndex'] as num).toDouble(),
  capIndex: (json['capIndex'] as num).toDouble(),
);

Map<String, dynamic> _$ConsumptionEntityModelToJson(
  ConsumptionEntityModel instance,
) => <String, dynamic>{
  'periodLabel': instance.periodLabel,
  'activeConsumption': instance.activeConsumption,
  'indConsumption': instance.indConsumption,
  'capConsumption': instance.capConsumption,
  'indRate': instance.indRate,
  'capRate': instance.capRate,
  't1Consumption': instance.t1Consumption,
  't2Consumption': instance.t2Consumption,
  't3Consumption': instance.t3Consumption,
  'activeIndex': instance.activeIndex,
  'indIndex': instance.indIndex,
  'capIndex': instance.capIndex,
};
