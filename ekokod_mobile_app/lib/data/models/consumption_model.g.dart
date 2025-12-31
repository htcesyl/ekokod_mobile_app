// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumptionPointModel _$ConsumptionPointModelFromJson(
  Map<String, dynamic> json,
) => ConsumptionPointModel(
  periodLabel: json['periodLabel'] as String,
  activeIndex: (json['activeIndex'] as num).toDouble(),
  indIndex: (json['indIndex'] as num).toDouble(),
  capIndex: (json['capIndex'] as num).toDouble(),
  t1Index: (json['t1Index'] as num).toDouble(),
  t2Index: (json['t2Index'] as num).toDouble(),
  t3Index: (json['t3Index'] as num).toDouble(),
  activeGenerationIndex: (json['activeGenerationIndex'] as num).toDouble(),
  indGenerationIndex: (json['indGenerationIndex'] as num).toDouble(),
  capGenerationIndex: (json['capGenerationIndex'] as num).toDouble(),
  u1Index: (json['u1Index'] as num).toDouble(),
  u2Index: (json['u2Index'] as num).toDouble(),
  u3Index: (json['u3Index'] as num).toDouble(),
  activeConsumption: (json['activeConsumption'] as num).toDouble(),
  indConsumption: (json['indConsumption'] as num).toDouble(),
  capConsumption: (json['capConsumption'] as num).toDouble(),
  indRate: (json['indRate'] as num).toDouble(),
  capRate: (json['capRate'] as num).toDouble(),
  t1Consumption: (json['t1Consumption'] as num).toDouble(),
  t2Consumption: (json['t2Consumption'] as num).toDouble(),
  t3Consumption: (json['t3Consumption'] as num).toDouble(),
  activeGeneration: (json['activeGeneration'] as num).toDouble(),
  indGeneration: (json['indGeneration'] as num).toDouble(),
  capGeneration: (json['capGeneration'] as num).toDouble(),
  u1Generation: (json['u1Generation'] as num).toDouble(),
  u2Generation: (json['u2Generation'] as num).toDouble(),
  u3Generation: (json['u3Generation'] as num).toDouble(),
);

Map<String, dynamic> _$ConsumptionPointModelToJson(
  ConsumptionPointModel instance,
) => <String, dynamic>{
  'periodLabel': instance.periodLabel,
  'activeIndex': instance.activeIndex,
  'indIndex': instance.indIndex,
  'capIndex': instance.capIndex,
  't1Index': instance.t1Index,
  't2Index': instance.t2Index,
  't3Index': instance.t3Index,
  'activeGenerationIndex': instance.activeGenerationIndex,
  'indGenerationIndex': instance.indGenerationIndex,
  'capGenerationIndex': instance.capGenerationIndex,
  'u1Index': instance.u1Index,
  'u2Index': instance.u2Index,
  'u3Index': instance.u3Index,
  'activeConsumption': instance.activeConsumption,
  'indConsumption': instance.indConsumption,
  'capConsumption': instance.capConsumption,
  'indRate': instance.indRate,
  'capRate': instance.capRate,
  't1Consumption': instance.t1Consumption,
  't2Consumption': instance.t2Consumption,
  't3Consumption': instance.t3Consumption,
  'activeGeneration': instance.activeGeneration,
  'indGeneration': instance.indGeneration,
  'capGeneration': instance.capGeneration,
  'u1Generation': instance.u1Generation,
  'u2Generation': instance.u2Generation,
  'u3Generation': instance.u3Generation,
};

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
    };

ConsumptionResponseModel _$ConsumptionResponseModelFromJson(
  Map<String, dynamic> json,
) => ConsumptionResponseModel(
  consumption: (json['consumption'] as List<dynamic>?)
      ?.map((e) => ConsumptionPointModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  consumptions: (json['consumptions'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => ConsumptionPointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
  pagination: json['pagination'] == null
      ? null
      : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConsumptionResponseModelToJson(
  ConsumptionResponseModel instance,
) => <String, dynamic>{
  'consumption': instance.consumption,
  'consumptions': instance.consumptions,
  'pagination': instance.pagination,
};
