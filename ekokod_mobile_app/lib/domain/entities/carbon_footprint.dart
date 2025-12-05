// lib/domain/entities/carbon_footprint.dart

class CarbonFootprintEntity {
  final double totalCo2Kg;
  final String periodLabel; // örn: "Ocak 2025"

  const CarbonFootprintEntity({
    required this.totalCo2Kg,
    required this.periodLabel,
  });
}
