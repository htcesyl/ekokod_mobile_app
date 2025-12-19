import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/bill_history_entity.dart';

part 'bill_history_item_model.g.dart';

@JsonSerializable()
class BillHistoryItemModel {
  final String monthKey;
  final double currentConsumptionIndex;
  final double totalActiveKWh;
  final double t1KWh;
  final double t2KWh;
  final double t3KWh;
  final double totalInductiveKVarh;
  final double totalCapacitiveKVarh;
  final double energyCost;
  final double distributionCost;
  final double capacityCost;
  final double greenEnergyCost;
  final double reactivePenalty;
  final double vatCost;
  final double otherTaxesCost;
  final double totalCost;
  final double inductiveRatio;
  final double capacitiveRatio;
  final bool reactivePenaltyApplied;
  final String startDate;
  final String endDate;
  final double activeGeneration;
  final double normalConsumption;
  final double overuseConsumption;
  final double normalConsumptionCost;
  final double overuseConsumptionCost;
  final double normalPrice;
  final double overusePrice;
  final bool isTwoPartCalculation;
  final double activeIndex;
  final double activeConsumption;
  final double t1Index;
  final double t1Consumption;
  final double t2Index;
  final double t2Consumption;
  final double t3Index;
  final double t3Consumption;
  final double indIndex;
  final double indConsumption;
  final double capIndex;
  final double capConsumption;
  final double activeGenerationIndex;
  final List<String>? analyzerIds;
  final String? pdfPath;

  BillHistoryItemModel({
    required this.monthKey,
    required this.currentConsumptionIndex,
    required this.totalActiveKWh,
    required this.t1KWh,
    required this.t2KWh,
    required this.t3KWh,
    required this.totalInductiveKVarh,
    required this.totalCapacitiveKVarh,
    required this.energyCost,
    required this.distributionCost,
    required this.capacityCost,
    required this.greenEnergyCost,
    required this.reactivePenalty,
    required this.vatCost,
    required this.otherTaxesCost,
    required this.totalCost,
    required this.inductiveRatio,
    required this.capacitiveRatio,
    required this.reactivePenaltyApplied,
    required this.startDate,
    required this.endDate,
    required this.activeGeneration,
    required this.normalConsumption,
    required this.overuseConsumption,
    required this.normalConsumptionCost,
    required this.overuseConsumptionCost,
    required this.normalPrice,
    required this.overusePrice,
    required this.isTwoPartCalculation,
    required this.activeIndex,
    required this.activeConsumption,
    required this.t1Index,
    required this.t1Consumption,
    required this.t2Index,
    required this.t2Consumption,
    required this.t3Index,
    required this.t3Consumption,
    required this.indIndex,
    required this.indConsumption,
    required this.capIndex,
    required this.capConsumption,
    required this.activeGenerationIndex,
    this.analyzerIds,
    this.pdfPath,
  });

  factory BillHistoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$BillHistoryItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillHistoryItemModelToJson(this);
}

// Extension for Entity conversion
extension BillHistoryItemModelExtension on BillHistoryItemModel {
  BillHistoryItemEntity toEntity() {
    return BillHistoryItemEntity(
      monthKey: monthKey,
      currentConsumptionIndex: currentConsumptionIndex,
      totalActiveKWh: totalActiveKWh,
      t1KWh: t1KWh,
      t2KWh: t2KWh,
      t3KWh: t3KWh,
      totalInductiveKVarh: totalInductiveKVarh,
      totalCapacitiveKVarh: totalCapacitiveKVarh,
      energyCost: energyCost,
      distributionCost: distributionCost,
      capacityCost: capacityCost,
      greenEnergyCost: greenEnergyCost,
      reactivePenalty: reactivePenalty,
      vatCost: vatCost,
      otherTaxesCost: otherTaxesCost,
      totalCost: totalCost,
      inductiveRatio: inductiveRatio,
      capacitiveRatio: capacitiveRatio,
      reactivePenaltyApplied: reactivePenaltyApplied,
      startDate: startDate,
      endDate: endDate,
      activeGeneration: activeGeneration,
      normalConsumption: normalConsumption,
      overuseConsumption: overuseConsumption,
      normalConsumptionCost: normalConsumptionCost,
      overuseConsumptionCost: overuseConsumptionCost,
      normalPrice: normalPrice,
      overusePrice: overusePrice,
      isTwoPartCalculation: isTwoPartCalculation,
      activeIndex: activeIndex,
      activeConsumption: activeConsumption,
      t1Index: t1Index,
      t1Consumption: t1Consumption,
      t2Index: t2Index,
      t2Consumption: t2Consumption,
      t3Index: t3Index,
      t3Consumption: t3Consumption,
      indIndex: indIndex,
      indConsumption: indConsumption,
      capIndex: capIndex,
      capConsumption: capConsumption,
      activeGenerationIndex: activeGenerationIndex,
      analyzerIds: analyzerIds,
      pdfPath: pdfPath,
    );
  }
}
