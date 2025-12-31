// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillModel _$BillModelFromJson(Map<String, dynamic> json) => BillModel(
  id: json['_id'] as String,
  monthKey: json['monthKey'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  totalKwh: (json['totalKwh'] as num).toDouble(),
  energyCost: (json['energyCost'] as num).toDouble(),
  distributionCost: (json['distributionCost'] as num).toDouble(),
  vatCost: (json['vatCost'] as num).toDouble(),
  reactivePenalty: (json['reactivePenalty'] as num).toDouble(),
  reactivePenaltyApplied: json['reactivePenaltyApplied'] as bool,
  inductiveRatio: (json['inductiveRatio'] as num).toDouble(),
  capacitiveRatio: (json['capacitiveRatio'] as num).toDouble(),
  pdfPath: json['pdfPath'] as String?,
  buildingId: json['buildingId'] as String?,
  analyzerIds: (json['analyzerIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BillModelToJson(BillModel instance) => <String, dynamic>{
  '_id': instance.id,
  'monthKey': instance.monthKey,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'totalAmount': instance.totalAmount,
  'totalKwh': instance.totalKwh,
  'energyCost': instance.energyCost,
  'distributionCost': instance.distributionCost,
  'vatCost': instance.vatCost,
  'reactivePenalty': instance.reactivePenalty,
  'reactivePenaltyApplied': instance.reactivePenaltyApplied,
  'inductiveRatio': instance.inductiveRatio,
  'capacitiveRatio': instance.capacitiveRatio,
  'pdfPath': instance.pdfPath,
  'buildingId': instance.buildingId,
  'analyzerIds': instance.analyzerIds,
};
