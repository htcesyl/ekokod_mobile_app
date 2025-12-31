// lib/domain/entities/production_entity.dart
// Üretim verileri için domain entity
// Clean Architecture: Domain layer - framework bağımlılığı yok

class ProductionEntity {
  final String periodLabel;        // "01/10/2025" veya "10/2025"
  final DateTime timestamp;        // Parse edilmiş tarih
  final double activeGeneration;   // Aktif üretim (kWh)
  final double indGeneration;      // Endüktif üretim (kVarh)
  final double capGeneration;      // Kapasitif üretim (kVarh)
  final double activeGenerationIndex; // Aktif üretim index
  final double indGenerationIndex;    // Endüktif üretim index
  final double capGenerationIndex;    // Kapasitif üretim index

  const ProductionEntity({
    required this.periodLabel,
    required this.timestamp,
    required this.activeGeneration,
    required this.indGeneration,
    required this.capGeneration,
    required this.activeGenerationIndex,
    required this.indGenerationIndex,
    required this.capGenerationIndex,
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

  /// Toplam üretim (aktif + endüktif + kapasitif)
  /// Not: Genelde sadece aktif üretim kullanılır
  double get totalGeneration {
    return activeGeneration + indGeneration + capGeneration;
  }

  /// Üretim var mı kontrolü
  bool get hasGeneration {
    return activeGeneration > 0 || indGeneration > 0 || capGeneration > 0;
  }
}
