// lib/domain/entities/bill_entity.dart

class BillEntity {
  final String id;
  final String period; // örn: "2025-01"
  final double totalAmount;
  final double totalKwh;

  const BillEntity({
    required this.id,
    required this.period,
    required this.totalAmount,
    required this.totalKwh,
  });
}
