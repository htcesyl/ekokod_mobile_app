// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TariffModel _$TariffModelFromJson(Map<String, dynamic> json) => TariffModel(
  originalTariffId: json['originalTariffId'] as String,
  effectiveFrom: json['effectiveFrom'] as String,
  currency: json['currency'] as String,
  energyType: json['energy_type'] as String,
  distributionType: json['distribution_type'] as String,
  distributionSystemUser: json['distribution_system_user'] as String,
  priceType: json['price_type'] as String,
  term: json['term'] as String,
  supplyCompany: json['supply_company'] as String,
  price: TariffPriceModel.fromJson(json['price'] as Map<String, dynamic>),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$TariffModelToJson(TariffModel instance) =>
    <String, dynamic>{
      'originalTariffId': instance.originalTariffId,
      'effectiveFrom': instance.effectiveFrom,
      'currency': instance.currency,
      'energy_type': instance.energyType,
      'distribution_type': instance.distributionType,
      'distribution_system_user': instance.distributionSystemUser,
      'price_type': instance.priceType,
      'term': instance.term,
      'supply_company': instance.supplyCompany,
      'price': instance.price,
      'isDefault': instance.isDefault,
    };

TariffPriceModel _$TariffPriceModelFromJson(Map<String, dynamic> json) =>
    TariffPriceModel(
      multiTimePrice: json['multi_time_price'] == null
          ? null
          : MultiTimePriceModel.fromJson(
              json['multi_time_price'] as Map<String, dynamic>,
            ),
      powerPrice: (json['power_price'] as num).toDouble(),
      overusePrice: (json['overuse_price'] as num).toDouble(),
      singleTimePrice: (json['single_time_price'] as num?)?.toDouble(),
      reactivePowerPrice: (json['reactive_power_price'] as num).toDouble(),
      distributionCost: (json['distribution_cost'] as num).toDouble(),
      greenEnergyPrice: (json['green_energy_price'] as num?)?.toDouble(),
      greenEnergyDistributionCost:
          (json['green_energy_distribution_cost'] as num?)?.toDouble(),
      vatRate: (json['vatRate'] as num?)?.toDouble(),
      otherTaxesRate: (json['otherTaxesRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TariffPriceModelToJson(TariffPriceModel instance) =>
    <String, dynamic>{
      'multi_time_price': instance.multiTimePrice,
      'power_price': instance.powerPrice,
      'overuse_price': instance.overusePrice,
      'single_time_price': instance.singleTimePrice,
      'reactive_power_price': instance.reactivePowerPrice,
      'distribution_cost': instance.distributionCost,
      'green_energy_price': instance.greenEnergyPrice,
      'green_energy_distribution_cost': instance.greenEnergyDistributionCost,
      'vatRate': ?instance.vatRate,
      'otherTaxesRate': ?instance.otherTaxesRate,
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
      companyId: json['company_id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      floors: (json['floors'] as num?)?.toInt(),
      contactPersons: json['contact_persons'] as List<dynamic>? ?? [],
      personelCount: (json['personel_count'] as num?)?.toInt(),
      totalArea: (json['total_area'] as num?)?.toDouble(),
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
      v: (json['__v'] as num?)?.toInt(),
      userInCharge: json['user_in_charge'] as String?,
      billHistoryJson: json['billHistory'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'company_id': instance.companyId,
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'long': instance.long,
      'floors': instance.floors,
      'contact_persons': instance.contactPersons,
      'personel_count': instance.personelCount,
      'total_area': instance.totalArea,
      'tariff': instance.tariff,
      'sector': instance.sector,
      'billCutoffDay': instance.billCutoffDay,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'user_in_charge': instance.userInCharge,
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
