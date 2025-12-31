# Tüketim, Üretim ve Faturalar - Entity ve Model Oluşturma Planı

## 📋 Genel Bakış
Bu plan, anasayfada kullanılacak tüketim, üretim ve fatura verileri için Clean Architecture'a uygun entity ve model'lerin oluşturulmasını içerir.

---

## 🔍 Mevcut Durum Analizi

### ✅ Mevcut Dosyalar:
1. **Tüketim:**
   - `ConsumptionPointModel` (API response modeli)
   - `ChartPointEntity` (Genel chart entity - sadece timestamp ve value)

2. **Üretim:**
   - ❌ ProductionEntity yok
   - ❌ ProductionModel yok
   - `ConsumptionPointModel` içinde `activeGeneration` var ama ayrı entity/model yok

3. **Faturalar:**
   - `BillEntity` (Çok basit - sadece id, period, totalAmount, totalKwh)
   - `BillHistoryItemEntity` (Detaylı fatura bilgileri)
   - `BillHistoryItemModel` (Detaylı fatura modeli)
   - ❌ BillModel yok (BillEntity için)

---

## 📁 Oluşturulacak Dosyalar

### **1. TÜKETİM (Consumption)**

#### **Entity:** `lib/domain/entities/consumption_entity.dart`
```dart
class ConsumptionEntity {
  final String periodLabel;        // "01/10/2025" veya "10/2025"
  final DateTime timestamp;        // Parse edilmiş tarih
  final double activeConsumption;  // Aktif tüketim (kWh)
  final double indConsumption;     // Endüktif tüketim (kVarh)
  final double capConsumption;     // Kapasitif tüketim (kVarh)
  final double indRate;            // Endüktif oran (%)
  final double capRate;            // Kapasitif oran (%)
  final double t1Consumption;      // T1 tüketimi
  final double t2Consumption;      // T2 tüketimi
  final double t3Consumption;      // T3 tüketimi
  final double activeIndex;        // Aktif index
  final double indIndex;           // Endüktif index
  final double capIndex;           // Kapasitif index
}
```

#### **Model:** `lib/data/models/consumption_entity_model.dart`
- `fromJson`: API'den gelen JSON'u parse eder
- `toJson`: JSON'a çevirir
- `toEntity`: ConsumptionEntity'ye dönüştürür
- `fromEntity`: Entity'den model oluşturur

**Not:** Mevcut `ConsumptionPointModel` API response modeli olarak kalacak, bu yeni model entity için özel olacak.

---

### **2. ÜRETİM (Production)**

#### **Entity:** `lib/domain/entities/production_entity.dart`
```dart
class ProductionEntity {
  final String periodLabel;        // "01/10/2025" veya "10/2025"
  final DateTime timestamp;        // Parse edilmiş tarih
  final double activeGeneration;   // Aktif üretim (kWh)
  final double indGeneration;      // Endüktif üretim (kVarh)
  final double capGeneration;      // Kapasitif üretim (kVarh)
  final double activeGenerationIndex; // Aktif üretim index
  final double indGenerationIndex;    // Endüktif üretim index
  final double capGenerationIndex;    // Kapasitif üretim index
}
```

#### **Model:** `lib/data/models/production_model.dart`
- `fromJson`: API'den gelen JSON'u parse eder (ConsumptionPointModel'den activeGeneration vb. alanları alır)
- `toJson`: JSON'a çevirir
- `toEntity`: ProductionEntity'ye dönüştürür
- `fromEntity`: Entity'den model oluşturur

**Not:** API'de üretim verileri `ConsumptionPointModel` içinde geliyor, bu model onu parse edecek.

---

### **3. FATURALAR (Bills)**

#### **Entity Güncelleme:** `lib/domain/entities/bill_entity.dart`
Mevcut `BillEntity` çok basit. Anasayfa için daha detaylı bir entity oluşturulacak:

```dart
class BillEntity {
  final String id;
  final String monthKey;           // "2025-12"
  final String period;              // "Aralık 2025" (gösterim için)
  final DateTime startDate;        // Fatura başlangıç tarihi
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
}
```

#### **Model:** `lib/data/models/bill_model.dart`
- `fromJson`: API'den gelen JSON'u parse eder (BillHistoryItemModel'den veya direkt API'den)
- `toJson`: JSON'a çevirir
- `toEntity`: BillEntity'ye dönüştürür
- `fromEntity`: Entity'den model oluşturur
- `fromBillHistoryItem`: BillHistoryItemModel'den dönüşüm

**Not:** `BillHistoryItemEntity` detaylı fatura bilgileri için kalacak, `BillEntity` anasayfa özeti için kullanılacak.

---

### **4. GÜNLÜK ÜRETİM-TÜKETİM (Daily Production-Consumption)**

Anasayfa için günlük üretim ve tüketimi birleştiren entity/model:

#### **Entity:** `lib/domain/entities/daily_production_consumption_entity.dart`
```dart
class DailyProductionConsumptionEntity {
  final DateTime date;             // Tarih
  final double dailyConsumption;   // Günlük tüketim (kWh)
  final double dailyProduction;    // Günlük üretim (kWh)
  final double netConsumption;    // Net tüketim (consumption - production)
  final String? buildingId;        // Bina ID (opsiyonel)
  final String? analyzerId;        // Analizör ID (opsiyonel)
}
```

#### **Model:** `lib/data/models/daily_production_consumption_model.dart`
- MongoDB için günlük veri modeli
- `fromJson`: MongoDB document'ini parse eder
- `toJson`: MongoDB'ye yazmak için JSON'a çevirir
- `toEntity`: DailyProductionConsumptionEntity'ye dönüştürür
- `fromEntity`: Entity'den model oluşturur

---

## ✅ Uygulama Sırası

### **Faz 1: Tüketim Entity ve Model**
1. ✅ `ConsumptionEntity` oluştur
2. ✅ `ConsumptionEntityModel` oluştur
3. ✅ `ConsumptionPointModel` ile entegrasyon (toEntity extension)

### **Faz 2: Üretim Entity ve Model**
4. ✅ `ProductionEntity` oluştur
5. ✅ `ProductionModel` oluştur
6. ✅ `ConsumptionPointModel` ile entegrasyon (üretim verilerini çıkarma)

### **Faz 3: Faturalar Entity ve Model**
7. ✅ `BillEntity`'yi genişlet/güncelle
8. ✅ `BillModel` oluştur
9. ✅ `BillHistoryItemModel` ile entegrasyon

### **Faz 4: Günlük Üretim-Tüketim (MongoDB için)**
10. ✅ `DailyProductionConsumptionEntity` oluştur
11. ✅ `DailyProductionConsumptionModel` oluştur

---

## 📝 Detaylı Entity/Model Yapıları

### **1. ConsumptionEntity**
```dart
// lib/domain/entities/consumption_entity.dart
class ConsumptionEntity {
  final String periodLabel;
  final DateTime timestamp;
  final double activeConsumption;
  final double indConsumption;
  final double capConsumption;
  final double indRate;
  final double capRate;
  final double t1Consumption;
  final double t2Consumption;
  final double t3Consumption;
  final double activeIndex;
  final double indIndex;
  final double capIndex;
  
  // Constructor
  // Helper methods: parsePeriodLabel, etc.
}
```

### **2. ProductionEntity**
```dart
// lib/domain/entities/production_entity.dart
class ProductionEntity {
  final String periodLabel;
  final DateTime timestamp;
  final double activeGeneration;
  final double indGeneration;
  final double capGeneration;
  final double activeGenerationIndex;
  final double indGenerationIndex;
  final double capGenerationIndex;
  
  // Constructor
  // Helper methods
}
```

### **3. BillEntity (Güncellenmiş)**
```dart
// lib/domain/entities/bill_entity.dart
class BillEntity {
  final String id;
  final String monthKey;
  final String period;
  final DateTime startDate;
  final DateTime endDate;
  final double totalAmount;
  final double totalKwh;
  final double energyCost;
  final double distributionCost;
  final double vatCost;
  final double reactivePenalty;
  final bool reactivePenaltyApplied;
  final double inductiveRatio;
  final double capacitiveRatio;
  final String? pdfPath;
  final String? buildingId;
  final List<String>? analyzerIds;
  
  // Constructor
  // Helper methods: formatPeriod, etc.
}
```

### **4. DailyProductionConsumptionEntity**
```dart
// lib/domain/entities/daily_production_consumption_entity.dart
class DailyProductionConsumptionEntity {
  final DateTime date;
  final double dailyConsumption;
  final double dailyProduction;
  final double netConsumption;
  final String? buildingId;
  final String? analyzerId;
  
  // Constructor
  // Helper methods: calculateNetConsumption, etc.
}
```

---

## 🔗 Model-Entity Dönüşümleri

### **ConsumptionEntityModel**
- `fromConsumptionPointModel`: Mevcut `ConsumptionPointModel`'den dönüşüm
- `toEntity`: `ConsumptionEntity`'ye dönüşüm

### **ProductionModel**
- `fromConsumptionPointModel`: `ConsumptionPointModel`'den üretim verilerini çıkarma
- `toEntity`: `ProductionEntity`'ye dönüşüm

### **BillModel**
- `fromBillHistoryItemModel`: `BillHistoryItemModel`'den dönüşüm
- `toEntity`: `BillEntity`'ye dönüşüm

### **DailyProductionConsumptionModel**
- `fromJson`: MongoDB document'inden
- `toEntity`: `DailyProductionConsumptionEntity`'ye dönüşüm

---

## 📌 Önemli Notlar

1. **Mevcut Dosyalar:**
   - `ConsumptionPointModel` API response modeli olarak kalacak
   - `ChartPointEntity` genel chart için kalacak
   - `BillHistoryItemEntity` detaylı fatura için kalacak

2. **Yeni Entity'ler:**
   - Domain layer'da, framework bağımlılığı yok
   - Sadece business logic içerir

3. **Yeni Model'ler:**
   - Data layer'da, JSON serialization içerir
   - Entity'ye dönüşüm metodları içerir

4. **Entegrasyon:**
   - Mevcut `ConsumptionPointModel` ile uyumlu çalışacak
   - `BillHistoryItemModel` ile uyumlu çalışacak

---

## 🎯 Sonuç

Bu plan ile:
- ✅ Tüketim için özel entity ve model
- ✅ Üretim için özel entity ve model
- ✅ Faturalar için genişletilmiş entity ve model
- ✅ MongoDB için günlük üretim-tüketim entity ve model

Tüm entity ve model'ler Clean Architecture prensiplerine uygun olacak.

---

**Son Güncelleme:** 2025-12-14
**Durum:** Planlama Aşaması
