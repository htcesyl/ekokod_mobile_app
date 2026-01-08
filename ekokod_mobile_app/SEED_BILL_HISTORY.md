# Bill History Verilerini Ekleme - Hızlı Başlangıç

## 🚀 Yöntem 1: Python Script ile (Önerilen - En Kolay)

### 1️⃣ Script'i Çalıştırın

Terminal'de backend klasörüne gidin ve script'i çalıştırın:

```bash
cd ekokod_backend
.\.venv\Scripts\python.exe import_bill_history.py
```

**Veya:**
```bash
cd ekokod_backend
python import_bill_history.py
```

### 2️⃣ Script Otomatik Olarak:

1. ✅ MongoDB'ye bağlanır (.env dosyasından MONGODB_URI ve DB_NAME alır)
2. ✅ Tüm binaları listeler
3. ✅ Building ID girmenizi ister (Enter'a basarsanız ilk bina seçilir)
4. ✅ Son 12 ayın billHistory verilerini ekler
5. ✅ Başarı mesajını gösterir

### 3️⃣ Örnek Çıktı:

```
============================================================
📦 Bill History Verilerini MongoDB'ye Ekleme
============================================================

🔌 MongoDB'ye bağlanılıyor...
   URI: mongodb://...
   Database: ekokod_db

📋 Mevcut binalar:
   1. Test 1 (ID: 6924b162f32b0add2260ece0)

🔍 Building seçimi:
   Enter'a basarsanız ilk bina seçilir
   Building ID girin (veya Enter): 

✅ Building bulundu: Test 1
   ID: 6924b162f32b0add2260ece0

📝 Bill History verileri ekleniyor...
   Toplam 12 ay verisi

✅ Başarılı!
   12 ay fatura verisi eklendi
   Aylar: 2025-12, 2025-11, 2025-10, 2025-09, 2025-08, 2025-07, 2025-06, 2025-05, 2025-04, 2025-03, 2025-02, 2025-01

💡 MongoDB Compass'ta kontrol edebilirsiniz:
   Database: ekokod_db
   Collection: buildings
   Building: Test 1

🔌 MongoDB bağlantısı kapatıldı
============================================================
```

### 4️⃣ Mobile App'i Test Edin

1. Mobile app'i yeniden başlatın (hot reload yeterli olabilir)
2. Faturalar sayfasına gidin
3. Artık görmelisiniz:
   - ✅ Son hesaplan fatura kartları (Tüketim ve Tutar)
   - ✅ Faturalar grafiği (son 12 ay bar chart)

---

## 🚀 Yöntem 2: API Endpoint ile (Alternatif)

### 1️⃣ Backend'i Başlatın

Terminal'de backend klasörüne gidin ve backend'i başlatın:

```bash
cd ekokod_backend
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

Backend başladığında şunu göreceksiniz:
```
INFO:     Uvicorn running on http://127.0.0.1:3000
```

---

### 2️⃣ Building ID'sini Bulun

**Yöntem A: Mobile App Loglarından (En Kolay)**

1. Mobile app'i çalıştırın
2. Log'larda şunu arayın:
   ```
   ✅ BuildingId kullanılıyor: 6924b162f32b0add2260ece0
   ```
3. Bu ID'yi kopyalayın

**Yöntem B: API ile**

Tarayıcıda veya Postman'de şu URL'yi açın:
```
http://localhost:3000/api/v1/building
```

Response'dan "Test 1" binasının `id` değerini bulun.

---

### 3️⃣ Seed Endpoint'ini Çağırın

**Yöntem A: Tarayıcıdan (GET isteği olarak - basit test için)**

Tarayıcıda şu URL'yi açın (building_id'yi kendi ID'nizle değiştirin):
```
http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed
```

⚠️ **Not:** Bu POST endpoint'i olduğu için tarayıcıdan çalışmayabilir. Aşağıdaki yöntemleri kullanın.

**Yöntem B: PowerShell ile (Windows)**

PowerShell'de şu komutu çalıştırın:

```powershell
Invoke-WebRequest -Uri "http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed" -Method POST
```

**Yöntem C: curl ile (Eğer curl yüklüyse)**

```bash
curl -X POST http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed
```

**Yöntem D: Postman veya Insomnia**

1. Postman/Insomnia'yı açın
2. Yeni bir POST isteği oluşturun
3. URL: `http://localhost:3000/api/v1/building/6924b162f32b0add2260ece0/bill-history/seed`
4. Method: `POST`
5. Send'e tıklayın

**Yöntem E: Python Script (En Güvenilir)**

Aşağıdaki Python script'ini oluşturun ve çalıştırın:

```python
import requests

# Building ID'nizi buraya yazın
BUILDING_ID = "6924b162f32b0add2260ece0"

url = f"http://localhost:3000/api/v1/building/{BUILDING_ID}/bill-history/seed"

response = requests.post(url)

print(f"Status Code: {response.status_code}")
print(f"Response: {response.json()}")
```

Script'i kaydedin (örnek: `seed_bill_history.py`) ve çalıştırın:
```bash
python seed_bill_history.py
```

---

### 4️⃣ Başarılı Response

Eğer başarılı olursa şu response'u göreceksiniz:

```json
{
  "success": true,
  "message": "Bina için 12 ay fatura verisi eklendi.",
  "months": ["2025-12", "2025-11", "2025-10", "2025-09", "2025-08", "2025-07", "2025-06", "2025-05", "2025-04", "2025-03", "2025-02", "2025-01"]
}
```

---

### 5️⃣ Mobile App'i Test Edin

1. Mobile app'i yeniden başlatın (hot reload yeterli olabilir)
2. Faturalar sayfasına gidin
3. Artık görmelisiniz:
   - ✅ Son hesaplan fatura kartları (Tüketim ve Tutar)
   - ✅ Faturalar grafiği (son 12 ay bar chart)

---

## 🔍 Sorun Giderme

**Problem:** "Connection refused" veya "Cannot connect"
- **Çözüm:** Backend'in çalıştığından emin olun (Adım 1)

**Problem:** "404 Not Found"
- **Çözüm:** URL'nin doğru olduğundan emin olun. Building ID'sini kontrol edin.

**Problem:** "500 Internal Server Error"
- **Çözüm:** MongoDB bağlantısını kontrol edin. Backend log'larına bakın.

**Problem:** "Building bulunamadı"
- **Çözüm:** Building ID'sinin doğru olduğundan emin olun. ObjectId formatında olmalı.

---

## 📝 Örnek Komutlar (Kopyala-Yapıştır)

**PowerShell:**
```powershell
# Building ID'yi değiştirin!
$buildingId = "6924b162f32b0add2260ece0"
Invoke-WebRequest -Uri "http://localhost:3000/api/v1/building/$buildingId/bill-history/seed" -Method POST
```

**Bash (Git Bash veya WSL):**
```bash
# Building ID'yi değiştirin!
BUILDING_ID="6924b162f32b0add2260ece0"
curl -X POST "http://localhost:3000/api/v1/building/$BUILDING_ID/bill-history/seed"
```

---

**İpucu:** En kolay yöntem **Postman** veya **Insomnia** kullanmaktır. GUI üzerinden kolayca test edebilirsiniz!
