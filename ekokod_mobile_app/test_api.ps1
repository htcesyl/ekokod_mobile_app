# Test script for Production-Consumption API

Write-Host "🧪 PRODUCTION-CONSUMPTION API TEST" -ForegroundColor Cyan
Write-Host "=" * 50

# 1. Health Check
Write-Host "`n1️⃣ Health Check..." -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "http://localhost:3000/health" -Method Get
    Write-Host "✅ Backend çalışıyor!" -ForegroundColor Green
    Write-Host "   Response: $($health | ConvertTo-Json)"
} catch {
    Write-Host "❌ Backend yanıt vermiyor!" -ForegroundColor Red
    exit 1
}

# 2. Test Verisi Ekle
Write-Host "`n2️⃣ Test verisi ekleniyor..." -ForegroundColor Yellow
$testData = @{
    date = "2025-12-14T00:00:00.000Z"
    dailyConsumption = 32.40
    dailyProduction = 15.20
    buildingId = "6924b162f32b0add2260ece0"
    analyzerId = "693744e1267022a0ec4abcc8"
} | ConvertTo-Json

try {
    $created = Invoke-RestMethod -Uri "http://localhost:3000/api/v1/production-consumption" -Method Post -Body $testData -ContentType "application/json"
    Write-Host "✅ Test verisi eklendi!" -ForegroundColor Green
    Write-Host "   ID: $($created.id)"
    Write-Host "   Tarih: $($created.date)"
    Write-Host "   Tüketim: $($created.dailyConsumption) kWh"
    Write-Host "   Üretim: $($created.dailyProduction) kWh"
    Write-Host "   Net Tüketim: $($created.netConsumption) kWh"
} catch {
    Write-Host "❌ Veri eklenemedi: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "   Detay: $responseBody" -ForegroundColor Red
    }
}

# 3. En Son Veriyi Çek
Write-Host "`n3️⃣ En son veri çekiliyor..." -ForegroundColor Yellow
try {
    $latest = Invoke-RestMethod -Uri "http://localhost:3000/api/v1/production-consumption/latest" -Method Get
    Write-Host "✅ En son veri çekildi!" -ForegroundColor Green
    Write-Host "   ID: $($latest.id)"
    Write-Host "   Tarih: $($latest.date)"
    Write-Host "   Tüketim: $($latest.dailyConsumption) kWh"
    Write-Host "   Üretim: $($latest.dailyProduction) kWh"
    Write-Host "   Net Tüketim: $($latest.netConsumption) kWh"
} catch {
    Write-Host "❌ Veri çekilemedi: $($_.Exception.Message)" -ForegroundColor Red
}

# 4. Belirli Tarih İçin Veri Çek
Write-Host "`n4️⃣ Belirli tarih için veri çekiliyor..." -ForegroundColor Yellow
try {
    $daily = Invoke-RestMethod -Uri "http://localhost:3000/api/v1/production-consumption/daily?date=2025-12-14" -Method Get
    Write-Host "✅ Tarih bazlı veri çekildi!" -ForegroundColor Green
    Write-Host "   ID: $($daily.id)"
    Write-Host "   Tarih: $($daily.date)"
    Write-Host "   Tüketim: $($daily.dailyConsumption) kWh"
    Write-Host "   Üretim: $($daily.dailyProduction) kWh"
    Write-Host "   Net Tüketim: $($daily.netConsumption) kWh"
} catch {
    Write-Host "❌ Veri çekilemedi: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n" + "=" * 50
Write-Host "✅ TEST TAMAMLANDI!" -ForegroundColor Green
Write-Host "`n📱 Şimdi mobile app'i çalıştırabilirsiniz:" -ForegroundColor Cyan
Write-Host "   flutter run" -ForegroundColor White
