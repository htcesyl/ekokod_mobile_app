// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_production_consumption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyProductionConsumptionModel _$DailyProductionConsumptionModelFromJson(
  Map<String, dynamic> json,
) => DailyProductionConsumptionModel(
  id: json['_id'] as String,
  date: DateTime.parse(json['date'] as String),
  dailyConsumption: (json['dailyConsumption'] as num).toDouble(),
  dailyProduction: (json['dailyProduction'] as num).toDouble(),
  netConsumption: (json['netConsumption'] as num).toDouble(),
  buildingId: json['buildingId'] as String?,
  analyzerId: json['analyzerId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DailyProductionConsumptionModelToJson(
  DailyProductionConsumptionModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'date': instance.date.toIso8601String(),
  'dailyConsumption': instance.dailyConsumption,
  'dailyProduction': instance.dailyProduction,
  'netConsumption': instance.netConsumption,
  'buildingId': instance.buildingId,
  'analyzerId': instance.analyzerId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
