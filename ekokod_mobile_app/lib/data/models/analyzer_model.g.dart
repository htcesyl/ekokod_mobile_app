// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzerModel _$AnalyzerModelFromJson(Map<String, dynamic> json) =>
    AnalyzerModel(
      id: json['_id'] as String,
      building: json['building'] as String,
      subIntegration: json['subIntegration'] as String,
      installationNumber: json['installationNumber'] as String,
      customerName: json['customerName'] as String,
      address: json['address'] as String,
      il: json['il'] as String?,
      ilce: json['ilce'] as String?,
      koyMahallesi: json['koyMahallesi'] as String?,
      caddesiSokagi: json['caddesiSokagi'] as String?,
      tarifeTipi: json['tarifeTipi'] as String?,
      tarifeTuru: json['tarifeTuru'] as String?,
      tesisatTurTanim: json['tesisatTurTanim'] as String?,
      kuruluGucu: json['kuruluGucu'] as String,
      koordinatX: json['koordinatX'] as String?,
      koordinatY: json['koordinatY'] as String?,
      meterNumber: json['meterNumber'] as String,
      meterModel: json['meterModel'] as String,
      meterMultiplier: json['meterMultiplier'] as String,
      muhatapNo: json['muhatapNo'] as String?,
      sayimNokTanim: json['sayimNokTanim'] as String?,
      lastLoadProfileDate: json['lastLoadProfileDate'] as String?,
      lastEndexDate: json['lastEndexDate'] as String?,
      definitionType: (json['definitionType'] as num).toInt(),
      lastDataDate:
          json['lastDataDate'] == null
              ? null
              : DateTime.parse(json['lastDataDate'] as String),
      isActive: json['isActive'] as bool,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num?)?.toInt(),
      billHistoryJson: json['billHistory'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AnalyzerModelToJson(AnalyzerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'building': instance.building,
      'subIntegration': instance.subIntegration,
      'installationNumber': instance.installationNumber,
      'customerName': instance.customerName,
      'address': instance.address,
      'il': instance.il,
      'ilce': instance.ilce,
      'koyMahallesi': instance.koyMahallesi,
      'caddesiSokagi': instance.caddesiSokagi,
      'tarifeTipi': instance.tarifeTipi,
      'tarifeTuru': instance.tarifeTuru,
      'tesisatTurTanim': instance.tesisatTurTanim,
      'kuruluGucu': instance.kuruluGucu,
      'koordinatX': instance.koordinatX,
      'koordinatY': instance.koordinatY,
      'meterNumber': instance.meterNumber,
      'meterModel': instance.meterModel,
      'meterMultiplier': instance.meterMultiplier,
      'muhatapNo': instance.muhatapNo,
      'sayimNokTanim': instance.sayimNokTanim,
      'lastLoadProfileDate': instance.lastLoadProfileDate,
      'lastEndexDate': instance.lastEndexDate,
      'definitionType': instance.definitionType,
      'lastDataDate': instance.lastDataDate?.toIso8601String(),
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'v': instance.v,
      'billHistory': instance.billHistoryJson,
    };

AnalyzerResponseModel _$AnalyzerResponseModelFromJson(
  Map<String, dynamic> json,
) => AnalyzerResponseModel(
  success: json['success'] as bool,
  analyzers:
      (json['analyzers'] as List<dynamic>)
          .map((e) => AnalyzerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AnalyzerResponseModelToJson(
  AnalyzerResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'analyzers': instance.analyzers,
};
