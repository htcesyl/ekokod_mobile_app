# Ekokod Backend - Sanal Sunucu Kurulum Adımları

Bu doküman, FastAPI backend sunucusunu yerel ortamda çalıştırmak için gerekli adımları içerir.

## Gereksinimler

- Python 3.8 veya üzeri
- pip (Python paket yöneticisi)

## Kurulum Adımları

### 1. Python Sanal Ortamı (Virtual Environment) Oluşturma

Windows PowerShell'de proje klasöründe şu komutu çalıştırın:

```powershell
python -m venv .venv
```

Bu komut `.venv` adında bir sanal ortam klasörü oluşturur.

### 2. Sanal Ortamı Aktif Etme

**Yöntem 1: PowerShell'de (Önerilen - En Kolay)**

PowerShell'de script çalıştırma hatası alıyorsanız, `activate.bat` dosyasını kullanın:

```powershell
.\.venv\Scripts\activate.bat
```

**Yöntem 2: PowerShell Execution Policy Geçici Çözüm**

Eğer yukarıdaki yöntem çalışmazsa, PowerShell'de şu komutu çalıştırın:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\.venv\Scripts\activate
```

**Yöntem 3: CMD (Command Prompt) Kullanma**

PowerShell yerine CMD kullanabilirsiniz:

```cmd
.venv\Scripts\activate.bat
```

**Yöntem 4: Sanal Ortamı Aktif Etmeden Doğrudan Kullanma (EN KOLAY)**

Sanal ortamı aktif etmeye gerek yok! Doğrudan sanal ortamdaki Python'u kullanabilirsiniz:

```powershell
# Bağımlılıkları yükle (sadece bir kez)
.\.venv\Scripts\python.exe -m pip install -r requirements.txt

# Sunucuyu başlat
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

veya daha kısa:

```powershell
.\.venv\Scripts\python.exe -m uvicorn main:app --reload --port 3000
```

Aktif olduğunda terminalinizde `(.venv)` öneki görünecektir.

### 3. Bağımlılıkları Yükleme

Sanal ortam aktifken, tüm gerekli paketleri yükleyin:

```powershell
pip install -r requirements.txt
```

### 4. Ortam Değişkenlerini Ayarlama

`.env.example` dosyasını kopyalayıp `.env` olarak kaydedin:

```powershell
Copy-Item .env.example .env
```

Ardından `.env` dosyasını düzenleyip kendi MongoDB bağlantı bilgilerinizi ve JWT secret key'inizi girin:

```
MONGODB_URI=mongodb+srv://kullanici:sifre@cluster.mongodb.net/
MONGODB_DB_NAME=ekokod_db
JWT_SECRET=güvenli-bir-secret-key-buraya
PORT=3000
```

### 5. Sunucuyu Başlatma

**Yöntem 1: Sanal Ortam Aktifken**

Sanal ortam aktifken, sunucuyu başlatmak için:

```powershell
uvicorn main:app --reload --port 3000
```

veya Python ile:

```powershell
python -m uvicorn main:app --reload --port 3000
```

**Yöntem 2: Sanal Ortamı Aktif Etmeden (Önerilen - PowerShell Hatası İçin)**

Sanal ortamı aktif etmeye gerek yok, doğrudan çalıştırın:

```powershell
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

veya:

```powershell
.\.venv\Scripts\python.exe -m uvicorn main:app --reload --port 3000
```

`--reload` parametresi kod değişikliklerinde otomatik yeniden başlatma sağlar (geliştirme için).

### 6. Sunucuyu Test Etme

Tarayıcınızda veya Postman'de şu adresi açın:

- **API Dokümantasyonu**: http://localhost:3000/docs
- **Health Check**: http://localhost:3000/health
- **Login Endpoint**: http://localhost:3000/api/v1/auth/login

## Hızlı Başlangıç (Özet)

**Normal Yöntem:**
```powershell
# 1. Sanal ortam oluştur
python -m venv .venv

# 2. Aktif et (PowerShell hatası alırsanız .bat kullanın)
.\.venv\Scripts\activate.bat

# 3. Bağımlılıkları yükle
pip install -r requirements.txt

# 4. .env dosyasını oluştur ve düzenle
Copy-Item .env.example .env
# .env dosyasını düzenleyin

# 5. Sunucuyu başlat
uvicorn main:app --reload --port 3000
```

**Alternatif Yöntem (PowerShell Hatası İçin - Önerilen):**
```powershell
# 1. Sanal ortam oluştur (zaten yapıldıysa atlayın)
python -m venv .venv

# 2. Bağımlılıkları yükle (sadece bir kez)
.\.venv\Scripts\python.exe -m pip install -r requirements.txt

# 3. .env dosyasını oluştur ve düzenle
Copy-Item .env.example .env
# .env dosyasını düzenleyin

# 4. Sunucuyu başlat (sanal ortamı aktif etmeden)
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

## Sunucuyu Durdurma

Terminal'de `Ctrl + C` tuşlarına basarak sunucuyu durdurabilirsiniz.

## Sanal Ortamdan Çıkış

Sanal ortamdan çıkmak için:

```powershell
deactivate
```

## Sorun Giderme

### PowerShell Execution Policy Hatası

**Hata:** "cannot be loaded because running scripts is disabled on this system"

**Çözüm 1 (EN KOLAY - Önerilen):** Sanal ortamı aktif etmeden doğrudan kullanın:
```powershell
# Bağımlılıkları yükle (sadece bir kez)
.\.venv\Scripts\python.exe -m pip install -r requirements.txt

# Sunucuyu başlat
.\.venv\Scripts\uvicorn.exe main:app --reload --port 3000
```

**Çözüm 2:** CMD (Command Prompt) kullanın:
```cmd
.venv\Scripts\activate.bat
```

**Çözüm 3:** PowerShell'de execution policy'yi geçici olarak değiştirin:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\.venv\Scripts\activate
```

**Çözüm 4 (Kalıcı - Yönetici Gerekir):** PowerShell'i yönetici olarak açıp:
```powershell
Set-ExecutionPolicy RemoteSigned
```

### Port zaten kullanılıyor hatası
Farklı bir port kullanın:
```powershell
uvicorn main:app --reload --port 3001
```

### MongoDB bağlantı hatası
`.env` dosyasındaki `MONGODB_URI` değerini kontrol edin.

### Paket yükleme hatası
Python ve pip versiyonlarınızı kontrol edin:
```powershell
python --version
pip --version
```

