// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TariffModel _$TariffModelFromJson(Map<String, dynamic> json) => TariffModel(
  originalTariffId: json['originalTariffId'] as String,
  effectiveFrom: json['effectiveFrom'] as String,
  currency: json['currency'] as String,
  energyType: json['energyType'] as String,
  distributionType: json['distributionType'] as String,
  distributionSystemUser: json['distributionSystemUser'] as String,
  priceType: json['priceType'] as String,
  term: json['term'] as String,
  supplyCompany: json['supplyCompany'] as String,
  price: TariffPriceModel.fromJson(json['price'] as Map<String, dynamic>),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$TariffModelToJson(TariffModel instance) =>
    <String, dynamic>{
      'originalTariffId': instance.originalTariffId,
      'effectiveFrom': instance.effectiveFrom,
      'currency': instance.currency,
      'energyType': instance.energyType,
      'distributionType': instance.distributionType,
      'distributionSystemUser': instance.distributionSystemUser,
      'priceType': instance.priceType,
      'term': instance.term,
      'supplyCompany': instance.supplyCompany,
      'price': instance.price,
      'isDefault': instance.isDefault,
    };

TariffPriceModel _$TariffPriceModelFromJson(Map<String, dynamic> json) =>
    TariffPriceModel(
      multiTimePrice: json['multiTimePrice'] == null
          ? null
          : MultiTimePriceModel.fromJson(
              json['multiTimePrice'] as Map<String, dynamic>,
            ),
      powerPrice: (json['powerPrice'] as num).toDouble(),
      overusePrice: (json['overusePrice'] as num).toDouble(),
      singleTimePrice: (json['singleTimePrice'] as num?)?.toDouble(),
      reactivePowerPrice: (json['reactivePowerPrice'] as num).toDouble(),
      distributionCost: (json['distributionCost'] as num).toDouble(),
      greenEnergyPrice: (json['greenEnergyPrice'] as num?)?.toDouble(),
      greenEnergyDistributionCost: (json['greenEnergyDistributionCost'] as num?)
          ?.toDouble(),
      vatRate: (json['vatRate'] as num).toDouble(),
      otherTaxesRate: (json['otherTaxesRate'] as num).toDouble(),
    );

Map<String, dynamic> _$TariffPriceModelToJson(TariffPriceModel instance) =>
    <String, dynamic>{
      'multiTimePrice': instance.multiTimePrice,
      'powerPrice': instance.powerPrice,
      'overusePrice': instance.overusePrice,
      'singleTimePrice': instance.singleTimePrice,
      'reactivePowerPrice': instance.reactivePowerPrice,
      'distributionCost': instance.distributionCost,
      'greenEnergyPrice': instance.greenEnergyPrice,
      'greenEnergyDistributionCost': instance.greenEnergyDistributionCost,
      'vatRate': instance.vatRate,
      'otherTaxesRate': instance.otherTaxesRate,
    };

MultiTimePriceModel _$MultiTimePriceModelFromJson(Map<String, dynamic> json) =>
    MultiTimePriceModel(
      t1: (json['t1'] as num).toDouble(),
      t2: (json['t2'] as num).toDouble(),
      t3: (json['t3'] as num).toDouble(),
    );

Map<String, dynamic> _$MultiTimePriceModelToJson(
  MultiTimePriceModel instance,
) => <String, dynamic>{'t1': instance.t1, 't2': instance.t2, 't3': instance.t3};

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: json['_id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      floors: (json['floors'] as num?)?.toInt(),
      contactPersons: json['contactPersons'] as List<dynamic>,
      personelCount: (json['personelCount'] as num?)?.toInt(),
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      tariff: json['tariff'] == null
          ? null
          : TariffModel.fromJson(json['tariff'] as Map<String, dynamic>),
      sector: json['sector'] as String?,
      billCutoffDay: (json['billCutoffDay'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num?)?.toInt(),
      userInCharge: json['userInCharge'] as String?,
      billHistoryJson: json['billHistory'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'long': instance.long,
      'floors': instance.floors,
      'contactPersons': instance.contactPersons,
      'personelCount': instance.personelCount,
      'totalArea': instance.totalArea,
      'tariff': instance.tariff,
      'sector': instance.sector,
      'billCutoffDay': instance.billCutoffDay,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'v': instance.v,
      'userInCharge': instance.userInCharge,
      'billHistory': instance.billHistoryJson,
    };

BuildingResponseModel _$BuildingResponseModelFromJson(
  Map<String, dynamic> json,
) => BuildingResponseModel(
  success: json['success'] as bool,
  buildings: (json['buildings'] as List<dynamic>)
      .map((e) => BuildingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BuildingResponseModelToJson(
  BuildingResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'buildings': instance.buildings,
};
