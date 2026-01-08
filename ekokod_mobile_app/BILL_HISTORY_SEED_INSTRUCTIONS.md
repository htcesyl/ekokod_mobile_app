# Bill History Verilerini Backend'e Ekleme Talimatları

## 📋 Özet
Backend'de "Test 1" binası için billHistory verileri boş. API dokümantasyonundaki örnek verileri backend'e eklemek için aşağıdaki adımları izleyin.

---

## 🔧 Adım 1: Building ID'sini Bulun

Önce "Test 1" binasının ID'sini bulmanız gerekiyor:

**Yöntem 1: API ile**
```bash
GET http://localhost:3000/api/v1/building
```

Response'dan "Test 1" binasının `id` değerini alın (örnek: `6924b162f32b0add2260ece0`)

**Yöntem 2: Mobile App Loglarından**
Mobile app'i çalıştırdığınızda log'larda şunu göreceksiniz:
```
✅ BuildingId kullanılıyor: 6924b162f32b0add2260ece0
```

---

## 🔧 Adım 2: Bill History Verilerini Ekleyin

Backend'e eklenen seed endpoint'ini kullanarak billHistory verilerini ekleyin:

**Endpoint:**
```
POST http://localhost:3000/api/v1/building/{building_id}/bill-history/seed
```

**Örnek:**
```bash
POST http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed
```

**Response:**
```json
{
  "success": true,
  "message": "Bina için 12 ay fatura verisi eklendi.",
  "months": ["2025-12", "2025-11", "2025-10", "2025-09", "2025-08", "2025-07", "2025-06", "2025-05", "2025-04", "2025-03", "2025-02", "2025-01"]
}
```

---

## 📊 Eklenen Veriler

Bu endpoint son 12 ayın fatura verilerini ekler:
- **2025-12** (Aralık 2025)
- **2025-11** (Kasım 2025)
- **2025-10** (Ekim 2025)
- **2025-09** (Eylül 2025)
- **2025-08** (Ağustos 2025)
- **2025-07** (Temmuz 2025)
- **2025-06** (Haziran 2025)
- **2025-05** (Mayıs 2025)
- **2025-04** (Nisan 2025)
- **2025-03** (Mart 2025)
- **2025-02** (Şubat 2025)
- **2025-01** (Ocak 2025)

Her ay için şu bilgiler eklenir:
- Tüketim verileri (totalActiveKWh, t1-t2-t3, reaktif değerler)
- Maliyet bilgileri (energyCost, distributionCost, vatCost, totalCost, vb.)
- Reaktif oranlar (inductiveRatio, capacitiveRatio)
- Index değerleri
- Tarih bilgileri (startDate, endDate)
- PDF yolu (pdfPath)

---

## 🧪 Test

1. Backend'i başlatın:
   ```bash
   cd ekokod_backend
   .\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
   ```

2. Building ID'sini alın (yukarıdaki Adım 1)

3. Seed endpoint'ini çağırın:
   ```bash
   curl -X POST http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed
   ```

4. Mobile app'i yeniden başlatın ve Faturalar sayfasına gidin

5. Artık "Test 1" binası için:
   - ✅ Son hesaplan fatura kartları dolu olmalı
   - ✅ Faturalar grafiği (son 12 ay) görünmeli

---

## ⚠️ Notlar

- Bu endpoint sadece test/development için kullanılmalıdır
- Production'da gerçek fatura verileri backend tarafından otomatik olarak eklenmelidir
- Endpoint her çağrıldığında mevcut billHistory verilerini günceller (üzerine yazar)

---

## 🔍 Sorun Giderme

**Problem:** Endpoint 404 hatası veriyor
- **Çözüm:** Backend'in çalıştığından emin olun ve endpoint yolunu kontrol edin

**Problem:** MongoDB izin hatası
- **Çözüm:** MongoDB kullanıcısının `update` yetkisi olduğundan emin olun

**Problem:** Building bulunamadı
- **Çözüm:** Building ID'sinin doğru olduğundan emin olun (ObjectId formatında olmalı)

---

**Son Güncelleme:** 2025-01-XX
