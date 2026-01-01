import 'package:json_annotation/json_annotation.dart';
import 'bill_history_item_model.dart';
import 'package:ekokod_mobile_app/domain/entities/building_entity.dart';
import 'package:ekokod_mobile_app/domain/entities/bill_history_entity.dart';

part 'building_model.g.dart';

@JsonSerializable()
class TariffModel {
  @JsonKey(name: 'originalTariffId')
  final String originalTariffId;
  @JsonKey(name: 'effectiveFrom')
  final String effectiveFrom;
  final String currency;
  @JsonKey(name: 'energy_type')
  final String energyType;
  @JsonKey(name: 'distribution_type')
  final String distributionType;
  @JsonKey(name: 'distribution_system_user')
  final String distributionSystemUser;
  @JsonKey(name: 'price_type')
  final String priceType;
  final String term;
  @JsonKey(name: 'supply_company')
  final String supplyCompany;
  final TariffPriceModel price;
  @JsonKey(name: 'isDefault')
  final bool isDefault;

  TariffModel({
    required this.originalTariffId,
    required this.effectiveFrom,
    required this.currency,
    required this.energyType,
    required this.distributionType,
    required this.distributionSystemUser,
    required this.priceType,
    required this.term,
    required this.supplyCompany,
    required this.price,
    required this.isDefault,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) =>
      _$TariffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TariffModelToJson(this);
}

@JsonSerializable()
class TariffPriceModel {
  @JsonKey(name: 'multi_time_price')
  final MultiTimePriceModel? multiTimePrice;
  @JsonKey(name: 'power_price')
  final double powerPrice;
  @JsonKey(name: 'overuse_price')
  final double overusePrice;
  @JsonKey(name: 'single_time_price')
  final double? singleTimePrice;
  @JsonKey(name: 'reactive_power_price')
  final double reactivePowerPrice;
  @JsonKey(name: 'distribution_cost')
  final double distributionCost;
  @JsonKey(name: 'green_energy_price')
  final double? greenEnergyPrice;
  @JsonKey(name: 'green_energy_distribution_cost')
  final double? greenEnergyDistributionCost;
  @JsonKey(name: 'vatRate', includeIfNull: false)
  final double? vatRate;
  @JsonKey(name: 'otherTaxesRate', includeIfNull: false)
  final double? otherTaxesRate;

  TariffPriceModel({
    this.multiTimePrice,
    required this.powerPrice,
    required this.overusePrice,
    this.singleTimePrice,
    required this.reactivePowerPrice,
    required this.distributionCost,
    this.greenEnergyPrice,
    this.greenEnergyDistributionCost,
    this.vatRate,
    this.otherTaxesRate,
  });

  factory TariffPriceModel.fromJson(Map<String, dynamic> json) =>
      _$TariffPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$TariffPriceModelToJson(this);
}

@JsonSerializable()
class MultiTimePriceModel {
  final double t1;
  final double t2;
  final double t3;

  MultiTimePriceModel({
    required this.t1,
    required this.t2,
    required this.t3,
  });

  factory MultiTimePriceModel.fromJson(Map<String, dynamic> json) =>
      _$MultiTimePriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MultiTimePriceModelToJson(this);
}

@JsonSerializable()
class BuildingModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'company_id')
  final String companyId;
  final String name;
  final String address;
  final double? lat;
  final double? long;
  final int? floors;
  @JsonKey(name: 'contact_persons', defaultValue: [])
  final List<dynamic> contactPersons;
  @JsonKey(name: 'personel_count')
  final int? personelCount;
  @JsonKey(name: 'total_area')
  final double? totalArea;
  final TariffModel? tariff;
  final String? sector;
  @JsonKey(name: 'billCutoffDay')
  final int? billCutoffDay;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'user_in_charge')
  final String? userInCharge;
  
  // billHistory Map<String, BillHistoryItemModel> olarak parse edilecek
  @JsonKey(name: 'billHistory')
  final Map<String, dynamic>? billHistoryJson;

  BuildingModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.address,
    this.lat,
    this.long,
    this.floors,
    this.contactPersons = const [],
    this.personelCount,
    this.totalArea,
    this.tariff,
    this.sector,
    this.billCutoffDay,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userInCharge,
    this.billHistoryJson,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);

  // Helper method: billHistory map'ini parse et
  Map<String, BillHistoryItemModel>? get billHistory {
    if (billHistoryJson == null) return null;
    
    return billHistoryJson!.map(
      (key, value) => MapEntry(
        key,
        BillHistoryItemModel.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  // Entity conversion method
  BuildingEntity toEntity() {
    // billHistory map'ini entity'ye çevir
    Map<String, BillHistoryItemEntity>? billHistoryEntity;
    if (billHistory != null) {
      billHistoryEntity = billHistory!.map(
        (key, value) => MapEntry(key, value.toEntity()),
      );
    }

    return BuildingEntity(
      id: id,
      companyId: companyId,
      name: name,
      address: address,
      lat: lat,
      long: long,
      floors: floors,
      personelCount: personelCount,
      totalArea: totalArea,
      sector: sector,
      billCutoffDay: billCutoffDay,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userInCharge: userInCharge,
      billHistory: billHistoryEntity,
    );
  }
}

@JsonSerializable()
class BuildingResponseModel {
  final bool success;
  final List<BuildingModel> buildings;

  BuildingResponseModel({
    required this.success,
    required this.buildings,
  });

  factory BuildingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingResponseModelToJson(this);
}

// Extension for Entity conversion
extension BuildingModelExtension on BuildingModel {
  BuildingEntity toEntity() {
    // billHistory map'ini entity'ye çevir
    Map<String, BillHistoryItemEntity>? billHistoryEntity;
    if (billHistory != null) {
      billHistoryEntity = billHistory!.map(
        (key, value) => MapEntry(key, value.toEntity()),
      );
    }

    return BuildingEntity(
      id: id,
      companyId: companyId,
      name: name,
      address: address,
      lat: lat,
      long: long,
      floors: floors,
      personelCount: personelCount,
      totalArea: totalArea,
      sector: sector,
      billCutoffDay: billCutoffDay,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userInCharge: userInCharge,
      billHistory: billHistoryEntity,
    );
  }
}
