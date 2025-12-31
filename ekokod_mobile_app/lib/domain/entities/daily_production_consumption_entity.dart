// lib/domain/entities/daily_production_consumption_entity.dart
// Günlük üretim ve tüketim verilerini birleştiren entity (anasayfa için)
// Clean Architecture: Domain layer - framework bağımlılığı yok

class DailyProductionConsumptionEntity {
  final DateTime date;             // Tarih
  final double dailyConsumption;   // Günlük tüketim (kWh)
  final double dailyProduction;    // Günlük üretim (kWh)
  final double netConsumption;    // Net tüketim (consumption - production)
  final String? buildingId;        // Bina ID (opsiyonel)
  final String? analyzerId;        // Analizör ID (opsiyonel)

  const DailyProductionConsumptionEntity({
    required this.date,
    required this.dailyConsumption,
    required this.dailyProduction,
    required this.netConsumption,
    this.buildingId,
    this.analyzerId,
  });

  /// Net tüketimi hesaplar (consumption - production)
  static double calculateNetConsumption(double consumption, double production) {
    return consumption - production;
  }

  /// Üretim tüketimden fazla mı kontrolü (net üretim var mı?)
  bool get hasNetProduction {
    return netConsumption < 0;
  }

  /// Net tüketim pozitif mi? (tüketim üretimden fazla)
  bool get hasNetConsumption {
    return netConsumption > 0;
  }

  /// Tüketim ve üretim eşit mi?
  bool get isBalanced {
    return netConsumption == 0;
  }

  /// Günlük tüketim formatı (kWh/Gün)
  String get formattedDailyConsumption {
    return '${dailyConsumption.toStringAsFixed(2)} kWh/Gün';
  }

  /// Günlük üretim formatı (kWh/Gün)
  String get formattedDailyProduction {
    return '${dailyProduction.toStringAsFixed(2)} kWh/Gün';
  }

  /// Net tüketim formatı (kWh/Gün veya -kWh/Gün)
  String get formattedNetConsumption {
    if (netConsumption >= 0) {
      return '${netConsumption.toStringAsFixed(2)} kWh/Gün';
    } else {
      return '${netConsumption.abs().toStringAsFixed(2)} kWh/Gün (Net Üretim)';
    }
  }
}
