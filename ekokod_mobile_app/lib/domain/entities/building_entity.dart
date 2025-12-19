import 'bill_history_entity.dart';

class BuildingEntity {
  final String id;
  final String companyId;
  final String name;
  final String address;
  final double? lat;
  final double? long;
  final int? floors;
  final int? personelCount;
  final double? totalArea;
  final String? sector;
  final int? billCutoffDay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userInCharge;
  final Map<String, BillHistoryItemEntity>? billHistory;

  BuildingEntity({
    required this.id,
    required this.companyId,
    required this.name,
    required this.address,
    this.lat,
    this.long,
    this.floors,
    this.personelCount,
    this.totalArea,
    this.sector,
    this.billCutoffDay,
    this.createdAt,
    this.updatedAt,
    this.userInCharge,
    this.billHistory,
  });
}
