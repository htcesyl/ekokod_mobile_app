import 'bill_history_entity.dart';

class AnalyzerEntity {
  final String id;
  final String buildingId;
  final String subIntegration;
  final String installationNumber;
  final String customerName;
  final String address;
  final String kuruluGucu;
  final String meterNumber;
  final String meterModel;
  final String meterMultiplier;
  final int definitionType;
  final DateTime? lastDataDate;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, BillHistoryItemEntity>? billHistory;

  AnalyzerEntity({
    required this.id,
    required this.buildingId,
    required this.subIntegration,
    required this.installationNumber,
    required this.customerName,
    required this.address,
    required this.kuruluGucu,
    required this.meterNumber,
    required this.meterModel,
    required this.meterMultiplier,
    required this.definitionType,
    this.lastDataDate,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.billHistory,
  });

  // Kurulu gücü double olarak al (reaktif ceza hesaplaması için)
  double get kuruluGucDouble {
    try {
      return double.parse(kuruluGucu);
    } catch (e) {
      return 0.0;
    }
  }
}
