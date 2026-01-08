# 📋 Faturalar Sayfası Test Rehberi

## ✅ Test Adımları

### 1️⃣ Backend'in Çalıştığından Emin Olun

**Terminal 1'de backend'i başlatın:**

```powershell
cd ekokod_backend
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

Backend başladığında şunu görmelisiniz:
```
INFO:     Uvicorn running on http://127.0.0.1:3000
```

**Test için (opsiyonel):**
Tarayıcıda şu URL'yi açın:
```
http://localhost:3000/api/v1/building
```

Eğer JSON response görüyorsanız backend çalışıyor! ✅

---

### 2️⃣ MongoDB'de Verilerin Olduğunu Kontrol Edin

**MongoDB Compass'ta kontrol edin:**
- Database: `ekokod_db` (veya .env'deki DB_NAME)
- Collection: `buildings`
- Building dokümanında `billHistory` alanı olmalı
- `billHistory` içinde 12 ay verisi olmalı (2025-01'den 2025-12'ye kadar)

**Eğer veri yoksa:**
```powershell
cd ekokod_backend
.\.venv\Scripts\python.exe import_bill_history.py
```

---

### 3️⃣ Mobile App'i Çalıştırın

**Terminal 2'de Flutter app'i çalıştırın:**

```powershell
flutter run
```

**Veya Android Studio/VS Code'dan çalıştırın.**

---

### 4️⃣ Faturalar Sayfasına Gidin

1. App açıldığında giriş yapın (eğer gerekliyse)
2. Alt menüden **"Faturalar"** sekmesine tıklayın (index: 2)

---

### 5️⃣ Log'larda Kontrol Edin

**Flutter log'larında şunları arayın:**

✅ **Başarılı durum:**
```
🔍 Bina kontrol ediliyor: Test 1
🔍 billHistory null mu? false
🔍 billHistory uzunluğu: 12
🔍 billHistory keys: [2025-12, 2025-11, 2025-10, ...]
✅ 12 adet aylık tüketim verisi hazırlandı
```

❌ **Hata durumu:**
```
⚠️ Bina için fatura geçmişi bulunamadı: Test 1
⚠️ billHistory null: true
```

---

### 6️⃣ UI'da Kontrol Edin

**Faturalar sayfasında görmelisiniz:**

#### ✅ Bina Seçimi Dropdown
- Dropdown'da bina ismi görünmeli
- Birden fazla bina varsa dropdown'dan seçim yapabilmelisiniz

#### ✅ Son Hesaplan Fatura Kartları
- **Tüketim** kartı: `XXXX.XX kWh` formatında
- **Tutar** kartı: `₺ XXXX.XX` formatında
- En son ayın (2025-12) verileri görünmeli

#### ✅ Faturalar Grafiği (Son 12 Ay)
- Bar chart görünmeli
- 12 adet bar olmalı (her ay için bir bar)
- X ekseninde ay isimleri (Oca, Şub, Mar, ...)
- Y ekseninde tutar değerleri (₺ 0K, ₺ 10K, ...)
- Bar'lara tıklayınca tooltip'te ay ve tutar görünmeli

---

## 🔍 Sorun Giderme

### Problem 1: "Bina bulunamadı" hatası

**Çözüm:**
- Backend'in çalıştığından emin olun
- `GET /api/v1/building` endpoint'inin çalıştığını kontrol edin
- MongoDB'de `buildings` collection'ında veri olduğundan emin olun

---

### Problem 2: "billHistory null" hatası

**Çözüm:**
1. MongoDB Compass'ta building dokümanını kontrol edin
2. `billHistory` alanı var mı?
3. Eğer yoksa `import_bill_history.py` script'ini çalıştırın:
   ```powershell
   cd ekokod_backend
   .\.venv\Scripts\python.exe import_bill_history.py
   ```

---

### Problem 3: Grafik görünmüyor

**Kontrol edin:**
- `billsChartData` null mu? (log'larda kontrol edin)
- `BillsChart` widget'ı doğru render ediliyor mu?
- `fl_chart` paketi yüklü mü? (`pubspec.yaml`)

---

### Problem 4: Backend bağlantı hatası

**Kontrol edin:**
- Backend çalışıyor mu? (`http://localhost:3000`)
- Android emülatör kullanıyorsanız: `10.0.2.2:3000` doğru mu?
- `lib/core/network/endpoints.dart` dosyasında `baseUrl` doğru mu?

---

## 📊 Beklenen Veriler

**Son 12 ayın fatura verileri:**
- 2025-12: ~35,002 TL
- 2025-11: ~149,455 TL
- 2025-10: ~178,629 TL
- 2025-09: ~212,463 TL
- 2025-08: ~256,067 TL
- 2025-07: ~254,887 TL
- 2025-06: ~240,727 TL
- 2025-05: ~240,727 TL
- 2025-04: ~240,727 TL
- 2025-03: ~240,727 TL
- 2025-02: ~240,727 TL
- 2025-01: ~240,727 TL

**En son fatura (2025-12):**
- Tüketim: 7,590.00 kWh
- Tutar: 35,002.51 TL

---

## ✅ Test Başarı Kriterleri

- [ ] Backend çalışıyor
- [ ] MongoDB'de billHistory verileri var
- [ ] Mobile app başarıyla çalışıyor
- [ ] Faturalar sayfası açılıyor
- [ ] Bina dropdown'ı çalışıyor
- [ ] Son hesaplan fatura kartları görünüyor (Tüketim ve Tutar)
- [ ] Faturalar grafiği görünüyor (12 ay bar chart)
- [ ] Log'larda hata yok
- [ ] Grafik bar'larına tıklayınca tooltip görünüyor

---

**İyi testler! 🚀**
