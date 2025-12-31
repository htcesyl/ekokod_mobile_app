// lib/data/models/bill_model.dart
// BillEntity için data model
// Clean Architecture: Data layer - JSON serialization ve entity dönüşümü

import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/bill_entity.dart';
import 'bill_history_item_model.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class BillModel {
  @JsonKey(name: '_id')
  final String id;
  final String monthKey;
  final String startDate; // "09-11-2025" formatı
  final String endDate;   // "09-12-2025" formatı
  final double totalAmount;
  final double totalKwh;
  final double energyCost;
  final double distributionCost;
  final double vatCost;
  final double reactivePenalty;
  final bool reactivePenaltyApplied;
  final double inductiveRatio;
  final double capacitiveRatio;
  final String? pdfPath;
  final String? buildingId;
  final List<String>? analyzerIds;

  BillModel({
    required this.id,
    required this.monthKey,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    required this.totalKwh,
    required this.energyCost,
    required this.distributionCost,
    required this.vatCost,
    required this.reactivePenalty,
    required this.reactivePenaltyApplied,
    required this.inductiveRatio,
    required this.capacitiveRatio,
    this.pdfPath,
    this.buildingId,
    this.analyzerIds,
  });

  /// JSON'dan model oluşturur
  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);

  /// Model'i JSON'a çevirir
  Map<String, dynamic> toJson() => _$BillModelToJson(this);

  /// BillHistoryItemModel'den BillModel oluşturur
  /// (Mevcut API response modelinden dönüşüm)
  factory BillModel.fromBillHistoryItemModel(
    BillHistoryItemModel historyItem, {
    String? id,
    String? buildingId,
  }) {
    return BillModel(
      id: id ?? historyItem.monthKey,
      monthKey: historyItem.monthKey,
      startDate: historyItem.startDate,
      endDate: historyItem.endDate,
      totalAmount: historyItem.totalCost,
      totalKwh: historyItem.totalActiveKWh,
      energyCost: historyItem.energyCost,
      distributionCost: historyItem.distributionCost,
      vatCost: historyItem.vatCost,
      reactivePenalty: historyItem.reactivePenalty,
      reactivePenaltyApplied: historyItem.reactivePenaltyApplied,
      inductiveRatio: historyItem.inductiveRatio,
      capacitiveRatio: historyItem.capacitiveRatio,
      pdfPath: historyItem.pdfPath,
      buildingId: buildingId,
      analyzerIds: historyItem.analyzerIds,
    );
  }

  /// Entity'den model oluşturur
  factory BillModel.fromEntity(BillEntity entity) {
    // DateTime'ı string'e çevir (format: "DD-MM-YYYY")
    String formatDate(DateTime date) {
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    }

    return BillModel(
      id: entity.id,
      monthKey: entity.monthKey,
      startDate: formatDate(entity.startDate),
      endDate: formatDate(entity.endDate),
      totalAmount: entity.totalAmount,
      totalKwh: entity.totalKwh,
      energyCost: entity.energyCost,
      distributionCost: entity.distributionCost,
      vatCost: entity.vatCost,
      reactivePenalty: entity.reactivePenalty,
      reactivePenaltyApplied: entity.reactivePenaltyApplied,
      inductiveRatio: entity.inductiveRatio,
      capacitiveRatio: entity.capacitiveRatio,
      pdfPath: entity.pdfPath,
      buildingId: entity.buildingId,
      analyzerIds: entity.analyzerIds,
    );
  }

  /// Model'i BillEntity'ye dönüştürür
  BillEntity toEntity() {
    final startDateParsed = _parseDateString(startDate) ?? DateTime.now();
    final endDateParsed = _parseDateString(endDate) ?? DateTime.now();
    final period = BillEntity.formatPeriod(monthKey);

    return BillEntity(
      id: id,
      monthKey: monthKey,
      period: period,
      startDate: startDateParsed,
      endDate: endDateParsed,
      totalAmount: totalAmount,
      totalKwh: totalKwh,
      energyCost: energyCost,
      distributionCost: distributionCost,
      vatCost: vatCost,
      reactivePenalty: reactivePenalty,
      reactivePenaltyApplied: reactivePenaltyApplied,
      inductiveRatio: inductiveRatio,
      capacitiveRatio: capacitiveRatio,
      pdfPath: pdfPath,
      buildingId: buildingId,
      analyzerIds: analyzerIds,
    );
  }

  /// Date string'i parse eder ("DD-MM-YYYY" formatı)
  static DateTime? _parseDateString(String dateString) {
    try {
      final parts = dateString.split('-');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

// Extension: BillHistoryItemModel'den direkt BillEntity'ye dönüşüm
extension BillHistoryItemModelToBillEntityExtension on BillHistoryItemModel {
  /// BillHistoryItemModel'den direkt BillEntity'ye dönüşüm
  BillEntity toBillEntity({String? id, String? buildingId}) {
    // StartDate ve EndDate'i parse et
    DateTime? parseDate(String dateString) {
      try {
        final parts = dateString.split('-');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
        return null;
      } catch (e) {
        return null;
      }
    }

    final startDateParsed = parseDate(startDate) ?? DateTime.now();
    final endDateParsed = parseDate(endDate) ?? DateTime.now();
    final period = BillEntity.formatPeriod(monthKey);

    return BillEntity(
      id: id ?? monthKey,
      monthKey: monthKey,
      period: period,
      startDate: startDateParsed,
      endDate: endDateParsed,
      totalAmount: totalCost,
      totalKwh: totalActiveKWh,
      energyCost: energyCost,
      distributionCost: distributionCost,
      vatCost: vatCost,
      reactivePenalty: reactivePenalty,
      reactivePenaltyApplied: reactivePenaltyApplied,
      inductiveRatio: inductiveRatio,
      capacitiveRatio: capacitiveRatio,
      pdfPath: pdfPath,
      buildingId: buildingId,
      analyzerIds: analyzerIds,
    );
  }
}
