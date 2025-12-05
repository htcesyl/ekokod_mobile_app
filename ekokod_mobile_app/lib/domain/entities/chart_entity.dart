// lib/domain/entities/chart_entity.dart

class ChartPointEntity {
  final DateTime timestamp;
  final double value;

  const ChartPointEntity({
    required this.timestamp,
    required this.value,
  });
}
