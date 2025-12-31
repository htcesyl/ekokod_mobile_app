# Üretim ve Tüketim Verileri - Clean Architecture Uygulama Planı

## 📋 Genel Bakış
Bu plan, MongoDB'ye manuel olarak yazılacak üretim ve tüketim verilerini anasayfada göstermek için Clean Architecture mimarisine uygun adım adım implementasyon rehberidir.

---

## 🎯 Hedef
Anasayfada günlük üretim ve tüketim verilerini MongoDB'den çekerek göstermek.

---

## 📁 Dosya Yapısı

```
lib/
├── domain/
│   ├── entities/
│   │   └── production_consumption_entity.dart          [YENİ]
│   └── repositories/
│       └── i_production_consumption_repository.dart   [YENİ]
│
├── data/
│   ├── models/
│   │   └── production_consumption_model.dart          [YENİ]
│   ├── datasources/
│   │   └── local_production_consumption_datasource.dart [YENİ]
│   └── repositories/
│       └── production_consumption_repository_impl.dart [YENİ]
│
├── application/
│   ├── home/
│   │   ├── get_daily_production_consumption_usecase.dart [YENİ]
│   │   └── home_cubit.dart                            [YENİ]
│
└── presentation/
    └── home/
        └── pages/
            └── home_page.dart                         [GÜNCELLENECEK]
```

---

## ✅ Adım Adım Uygulama Planı

### **ADIM 1: Domain Layer - Entity Oluşturma**

**Dosya:** `lib/domain/entities/production_consumption_entity.dart`

**Açıklama:** Anasayfada gösterilecek günlük üretim ve tüketim verilerini temsil eden entity.

**İçerik:**
- `id`: String (MongoDB document ID)
- `date`: DateTime (Tarih)
- `dailyConsumption`: double (Günlük tüketim - kWh)
- `dailyProduction`: double (Günlük üretim - kWh)
- `buildingId`: String? (Opsiyonel - hangi binaya ait)
- `analyzerId`: String? (Opsiyonel - hangi analizöre ait)
- `createdAt`: DateTime?
- `updatedAt`: DateTime?

**Not:** Entity sadece business logic içerir, framework bağımlılığı yoktur.

---

### **ADIM 2: Data Layer - Model Oluşturma**

**Dosya:** `lib/data/models/production_consumption_model.dart`

**Açıklama:** MongoDB'den gelen JSON verilerini parse eden model.

**Özellikler:**
- `fromJson`: MongoDB document'ini parse eder
- `toJson`: MongoDB'ye yazmak için JSON'a çevirir
- `toEntity`: Domain entity'ye dönüştürür
- `fromEntity`: Entity'den model oluşturur

**MongoDB Document Yapısı:**
```json
{
  "_id": "507f1f77bcf86cd799439011",
  "date": "2025-12-14T00:00:00.000Z",
  "dailyConsumption": 32.40,
  "dailyProduction": 15.20,
  "buildingId": "6924b162f32b0add2260ece0",
  "analyzerId": "693744e1267022a0ec4abcc8",
  "createdAt": "2025-12-14T10:00:00.000Z",
  "updatedAt": "2025-12-14T10:00:00.000Z"
}
```

---

### **ADIM 3: Data Layer - Local DataSource Oluşturma**

**Dosya:** `lib/data/datasources/local_production_consumption_datasource.dart`

**Açıklama:** MongoDB ile iletişim kuran data source.

**Kullanılacak Paket:** 
- `mongodb_dart` veya `realm` (projeye eklenmeli)

**Metodlar:**
- `getDailyProductionConsumption(DateTime date)`: Belirli bir tarih için veri getirir
- `getDailyProductionConsumptionRange(DateTime startDate, DateTime endDate)`: Tarih aralığı için veri getirir
- `getLatestProductionConsumption()`: En son eklenen veriyi getirir
- `insertProductionConsumption(ProductionConsumptionModel model)`: Yeni veri ekler (manuel yazma için)
- `updateProductionConsumption(String id, ProductionConsumptionModel model)`: Veri günceller

**Not:** Data source sadece veri işlemleri yapar, business logic içermez.

---

### **ADIM 4: Domain Layer - Repository Interface**

**Dosya:** `lib/domain/repositories/i_production_consumption_repository.dart`

**Açıklama:** Repository'nin domain katmanındaki interface'i.

**Metodlar:**
- `Future<ProductionConsumptionEntity?> getDailyProductionConsumption(DateTime date)`
- `Future<List<ProductionConsumptionEntity>> getDailyProductionConsumptionRange(DateTime startDate, DateTime endDate)`
- `Future<ProductionConsumptionEntity?> getLatestProductionConsumption()`

**Not:** Interface sadece entity döner, model dönmez.

---

### **ADIM 5: Data Layer - Repository Implementation**

**Dosya:** `lib/data/repositories/production_consumption_repository_impl.dart`

**Açıklama:** Repository interface'inin implementasyonu.

**Sorumluluklar:**
- Local data source'dan veri çeker
- Model'i entity'ye dönüştürür
- Hata yönetimi yapar
- Network info kontrolü yapabilir (opsiyonel)

**Not:** Repository, data source'dan gelen model'i entity'ye çevirir.

---

### **ADIM 6: Application Layer - UseCase Oluşturma**

**Dosya:** `lib/application/home/get_daily_production_consumption_usecase.dart`

**Açıklama:** Anasayfa için günlük üretim/tüketim verilerini getiren use case.

**Metodlar:**
- `Future<Either<Failure, ProductionConsumptionEntity?>> call(DateTime date)`: Belirli tarih için
- `Future<Either<Failure, ProductionConsumptionEntity?>> getLatest()`: En son veri için

**Not:** UseCase, repository'yi kullanır ve Either döner (hata yönetimi için).

---

### **ADIM 7: Application Layer - Cubit Oluşturma**

**Dosya:** `lib/application/home/home_cubit.dart`

**Açıklama:** Anasayfa state yönetimi için Cubit.

**State Sınıfları:**
- `HomeInitial`: Başlangıç durumu
- `HomeLoading`: Yükleniyor
- `HomeLoaded`: Veri yüklendi (ProductionConsumptionEntity içerir)
- `HomeError`: Hata durumu (String message)

**Metodlar:**
- `loadDailyProductionConsumption(DateTime date)`: Belirli tarih için yükle
- `loadLatestProductionConsumption()`: En son veriyi yükle
- `refresh()`: Yenile

---

### **ADIM 8: Dependency Injection Kayıtları**

**Dosya:** `lib/injections/injection_container.dart`

**Eklemeler:**
1. MongoDB client/database instance kaydı
2. Local data source kaydı
3. Repository kaydı
4. UseCase kaydı
5. Cubit kaydı (factory olarak)

**Sıralama:**
```dart
// 1. MongoDB Database
sl.registerLazySingleton<Database>(() => ...);

// 2. Data Source
sl.registerLazySingleton<LocalProductionConsumptionDataSource>(
  () => LocalProductionConsumptionDataSourceImpl(sl()),
);

// 3. Repository
sl.registerLazySingleton<IProductionConsumptionRepository>(
  () => ProductionConsumptionRepositoryImpl(sl()),
);

// 4. UseCase
sl.registerLazySingleton<GetDailyProductionConsumptionUseCase>(
  () => GetDailyProductionConsumptionUseCase(sl()),
);

// 5. Cubit (factory - her sayfa için yeni instance)
sl.registerFactory<HomeCubit>(
  () => HomeCubit(getDailyProductionConsumptionUseCase: sl()),
);
```

---

### **ADIM 9: Presentation Layer - HomePage Güncelleme**

**Dosya:** `lib/presentation/home/pages/home_page.dart`

**Değişiklikler:**
1. `BlocProvider` veya `BlocBuilder` ekle
2. `_buildSummaryCards` metodunu güncelle:
   - `dailyConsumption` değerini Cubit'ten al
   - `dailyProduction` değerini Cubit'ten al
3. `initState`'te Cubit'i tetikle:
   - `context.read<HomeCubit>().loadLatestProductionConsumption()`

**Örnek Kullanım:**
```dart
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if (state is HomeLoaded) {
      return DataSummaryCard(
        title: 'Günlük Tüketim',
        value: '${state.data.dailyConsumption.toStringAsFixed(2)} kWh/Gün',
        isCurrency: false,
      );
    }
    // Loading veya error state'leri
  },
)
```

---

## 🔧 Gereksinimler

### **Paketler (pubspec.yaml):**
```yaml
dependencies:
  # MongoDB için (seçeneklerden biri)
  mongodb_dart: ^0.7.0
  # VEYA
  realm: ^latest
  
  # Mevcut paketler
  flutter_bloc: ^latest
  get_it: ^latest
  equatable: ^latest
  dartz: ^latest  # Either için
```

### **MongoDB Bağlantı Ayarları:**
- Connection string
- Database adı
- Collection adı: `production_consumption`

---

## 📝 MongoDB Collection Şeması

```javascript
{
  "_id": ObjectId,
  "date": ISODate,           // Tarih (index olmalı)
  "dailyConsumption": Number, // kWh
  "dailyProduction": Number,  // kWh
  "buildingId": String,        // Opsiyonel
  "analyzerId": String,       // Opsiyonel
  "createdAt": ISODate,
  "updatedAt": ISODate
}
```

**Index Önerileri:**
- `date`: 1 (ascending) - Tarih bazlı sorgular için
- `buildingId`: 1 (opsiyonel)
- `analyzerId`: 1 (opsiyonel)

---

## 🎨 UI Entegrasyonu

### **Anasayfa Kartları:**
1. **Günlük Tüketim Kartı:**
   - Başlık: "Günlük Tüketim"
   - Değer: `{dailyConsumption} kWh/Gün`
   - Renk: Mavi tonları

2. **Günlük Üretim Kartı:**
   - Başlık: "Günlük Üretim"
   - Değer: `{dailyProduction} kWh/Gün`
   - Renk: Yeşil tonları

### **Loading State:**
- Skeleton loader veya shimmer effect

### **Error State:**
- Hata mesajı gösterimi
- Retry butonu

---

## ✅ Test Senaryoları

1. **Repository Test:**
   - Model'den entity'ye dönüşüm
   - Hata durumları

2. **UseCase Test:**
   - Başarılı veri çekme
   - Hata durumları

3. **Cubit Test:**
   - State geçişleri
   - Loading → Loaded
   - Loading → Error

4. **UI Test:**
   - Veri gösterimi
   - Loading gösterimi
   - Hata gösterimi

---

## 🚀 Uygulama Sırası

1. ✅ **ADIM 1:** Entity oluştur
2. ✅ **ADIM 2:** Model oluştur
3. ✅ **ADIM 3:** Local DataSource oluştur (MongoDB bağlantısı)
4. ✅ **ADIM 4:** Repository Interface oluştur
5. ✅ **ADIM 5:** Repository Implementation oluştur
6. ✅ **ADIM 6:** UseCase oluştur
7. ✅ **ADIM 7:** Cubit oluştur
8. ✅ **ADIM 8:** Dependency Injection kayıtları
9. ✅ **ADIM 9:** HomePage güncelleme

---

## 📌 Önemli Notlar

1. **Clean Architecture Prensipleri:**
   - Domain layer hiçbir framework bağımlılığı içermez
   - Data layer sadece veri işlemleri yapar
   - Application layer business logic içerir
   - Presentation layer sadece UI işlemleri yapar

2. **Error Handling:**
   - Tüm katmanlarda hata yönetimi yapılmalı
   - Either pattern kullanılabilir
   - User-friendly hata mesajları gösterilmeli

3. **Performance:**
   - MongoDB index'leri doğru kullanılmalı
   - Cache mekanizması eklenebilir (opsiyonel)
   - Lazy loading kullanılabilir

4. **MongoDB Bağlantısı:**
   - Connection string environment variable olarak saklanmalı
   - Connection pooling kullanılmalı
   - Timeout ayarları yapılmalı

---

## 🔄 Gelecek Geliştirmeler

1. **Cache Mekanizması:**
   - Hive veya SharedPreferences ile local cache
   - Offline çalışma desteği

2. **Real-time Updates:**
   - MongoDB Change Streams
   - WebSocket bağlantısı

3. **Analytics:**
   - Tüketim/üretim trend analizi
   - Grafik gösterimleri

4. **Filtreleme:**
   - Bina bazlı filtreleme
   - Analizör bazlı filtreleme
   - Tarih aralığı filtreleme

---

## 📚 Referanslar

- Clean Architecture (Robert C. Martin)
- Flutter BLoC Pattern
- MongoDB Dart Driver Documentation
- Mevcut proje yapısı (building, analyzer, consumption modülleri)

---

**Son Güncelleme:** 2025-12-14
**Hazırlayan:** AI Assistant
**Durum:** Planlama Aşaması
