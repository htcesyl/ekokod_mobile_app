class BillHistoryItemEntity {
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

  BillHistoryItemEntity({
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
}
