// lib/domain/entities/consumption_entity.dart
// Tüketim verileri için domain entity
// Clean Architecture: Domain layer - framework bağımlılığı yok

class ConsumptionEntity {
  final String periodLabel;        // "01/10/2025" veya "10/2025"
  final DateTime timestamp;        // Parse edilmiş tarih
  final double activeConsumption;  // Aktif tüketim (kWh)
  final double indConsumption;     // Endüktif tüketim (kVarh)
  final double capConsumption;     // Kapasitif tüketim (kVarh)
  final double indRate;            // Endüktif oran (%)
  final double capRate;            // Kapasitif oran (%)
  final double t1Consumption;      // T1 tüketimi (kWh)
  final double t2Consumption;      // T2 tüketimi (kWh)
  final double t3Consumption;      // T3 tüketimi (kWh)
  final double activeIndex;        // Aktif index
  final double indIndex;           // Endüktif index
  final double capIndex;           // Kapasitif index

  const ConsumptionEntity({
    required this.periodLabel,
    required this.timestamp,
    required this.activeConsumption,
    required this.indConsumption,
    required this.capConsumption,
    required this.indRate,
    required this.capRate,
    required this.t1Consumption,
    required this.t2Consumption,
    required this.t3Consumption,
    required this.activeIndex,
    required this.indIndex,
    required this.capIndex,
  });

  /// PeriodLabel'dan DateTime'a çevirme helper metodu
  /// Daily format: "01/10/2025" (DD/MM/YYYY)
  /// Monthly format: "10/2025" (MM/YYYY)
  static DateTime? parsePeriodLabel(String periodLabel) {
    try {
      // Daily format: "01/10/2025" (DD/MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 3) {
        final parts = periodLabel.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
      
      // Monthly format: "10/2025" (MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 2) {
        final parts = periodLabel.split('/');
        if (parts.length == 2) {
          final month = int.parse(parts[0]);
          final year = int.parse(parts[1]);
          return DateTime(year, month, 1); // Ayın ilk günü
        }
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Toplam tüketim (T1 + T2 + T3)
  double get totalTimeConsumption {
    return t1Consumption + t2Consumption + t3Consumption;
  }

  /// Reaktif ceza uygulanıp uygulanmayacağını kontrol eder
  /// Kurulu güç >= 30 kW ise: Endüktif %20, Kapasitif %15
  /// Kurulu güç < 30 kW ise: Endüktif %33, Kapasitif %20
  bool shouldApplyReactivePenalty(double kuruluGuc) {
    final inductiveThreshold = kuruluGuc >= 30 ? 20.0 : 33.0;
    final capacitiveThreshold = kuruluGuc >= 30 ? 15.0 : 20.0;
    
    return indRate > inductiveThreshold || capRate > capacitiveThreshold;
  }
}
