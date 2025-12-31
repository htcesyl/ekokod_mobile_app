// lib/domain/entities/bill_entity.dart
// Fatura verileri için domain entity (anasayfa özeti için)
// Clean Architecture: Domain layer - framework bağımlılığı yok

class BillEntity {
  final String id;
  final String monthKey;           // "2025-12" (API'den gelen format)
  final String period;           // "Aralık 2025" (gösterim için formatlanmış)
  final DateTime startDate;         // Fatura başlangıç tarihi
  final DateTime endDate;           // Fatura bitiş tarihi
  final double totalAmount;        // Toplam tutar (TL)
  final double totalKwh;           // Toplam kWh
  final double energyCost;         // Enerji maliyeti
  final double distributionCost;   // Dağıtım maliyeti
  final double vatCost;            // KDV
  final double reactivePenalty;    // Reaktif ceza
  final bool reactivePenaltyApplied; // Reaktif ceza uygulandı mı?
  final double inductiveRatio;     // Endüktif oran (%)
  final double capacitiveRatio;    // Kapasitif oran (%)
  final String? pdfPath;           // PDF yolu
  final String? buildingId;        // Bina ID (opsiyonel)
  final List<String>? analyzerIds; // Analizör ID'leri (opsiyonel)

  const BillEntity({
    required this.id,
    required this.monthKey,
    required this.period,
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

  /// MonthKey'den period string'i oluşturur
  /// "2025-12" -> "Aralık 2025"
  static String formatPeriod(String monthKey) {
    try {
      final parts = monthKey.split('-');
      if (parts.length == 2) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        
        final monthNames = [
          '', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
          'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
        ];
        
        if (month >= 1 && month <= 12) {
          return '${monthNames[month]} $year';
        }
      }
      return monthKey;
    } catch (e) {
      return monthKey;
    }
  }

  /// StartDate ve EndDate'den period string'i oluşturur
  static String formatPeriodFromDates(DateTime startDate, DateTime endDate) {
    final monthNames = [
      '', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    
    final month = monthNames[startDate.month];
    final year = startDate.year;
    
    return '$month $year';
  }

  /// Reaktif ceza uygulanıp uygulanmayacağını kontrol eder
  /// Kurulu güç >= 30 kW ise: Endüktif %20, Kapasitif %15
  /// Kurulu güç < 30 kW ise: Endüktif %33, Kapasitif %20
  bool shouldApplyReactivePenalty(double kuruluGuc) {
    final inductiveThreshold = kuruluGuc >= 30 ? 20.0 : 33.0;
    final capacitiveThreshold = kuruluGuc >= 30 ? 15.0 : 20.0;
    
    return inductiveRatio > inductiveThreshold || capacitiveRatio > capacitiveThreshold;
  }

  /// Toplam maliyet (enerji + dağıtım + KDV + reaktif ceza)
  double get totalCost {
    return energyCost + distributionCost + vatCost + reactivePenalty;
  }
}
