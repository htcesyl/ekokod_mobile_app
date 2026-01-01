import os
from datetime import datetime, timedelta

from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr
from pymongo import MongoClient
from bson.objectid import ObjectId
from dotenv import load_dotenv
import jwt
import bcrypt
from typing import Any, Dict

load_dotenv()

MONGODB_URI = os.getenv("MONGODB_URI")
DB_NAME = os.getenv("MONGODB_DB_NAME")
JWT_SECRET = os.getenv("JWT_SECRET")
PORT = int(os.getenv("PORT", "3000"))

if not MONGODB_URI or not DB_NAME or not JWT_SECRET:
  raise RuntimeError("MONGODB_URI / DB_NAME / JWT_SECRET .env içinde tanımlı olmalı")

print("MONGODB_URI:", repr(MONGODB_URI))
client = MongoClient(MONGODB_URI)
db = client[DB_NAME]
users_collection = db["users"]
alarms_collection = db["alarms"]
production_consumption_collection = db["production_consumption"]
device_tokens_collection = db["device_tokens"]

app = FastAPI(
    title="Ekokod Backend API",
    version="1.0.0"
)

# Debug: Backend dosyasının yüklendiğini kontrol et
print("=" * 50)
print("🔔 Backend main.py dosyası yüklendi!")
print(f"📁 Çalışma dizini: {os.getcwd()}")
print(f"📄 Dosya yolu: {__file__}")
print("=" * 50)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class LoginResponse(BaseModel):
    token: str
    userName: str
    phone: str | None = None
    company: str | None = None  # ObjectId string olarak
    userType: str | None = None


class ProductionConsumptionRequest(BaseModel):
    date: str  # ISO format: "2025-12-14T00:00:00.000Z"
    dailyConsumption: float
    dailyProduction: float
    buildingId: str | None = None
    analyzerId: str | None = None


class ProductionConsumptionResponse(BaseModel):
    id: str
    date: str
    dailyConsumption: float
    dailyProduction: float
    netConsumption: float
    buildingId: str | None = None
    analyzerId: str | None = None
    createdAt: str | None = None
    updatedAt: str | None = None


class DeviceTokenRequest(BaseModel):
    userId: str
    fcmToken: str
    platform: str  # "android" veya "ios" (save için zorunlu)


class DeviceTokenDeleteRequest(BaseModel):
    userId: str
    fcmToken: str


class DeviceTokenResponse(BaseModel):
    success: bool
    message: str


# ---- Helper Functions ----

def serialize_alarm(alarm: Any) -> Any:
    """MongoDB alarm dokümanını serialize eder (ObjectId ve datetime'ları string'e çevirir)"""
    if isinstance(alarm, ObjectId):
        return str(alarm)
    elif isinstance(alarm, datetime):
        return alarm.isoformat()
    elif isinstance(alarm, dict):
        # Dict için recursive serialize
        return {key: serialize_alarm(value) for key, value in alarm.items()}
    elif isinstance(alarm, list):
        # List için her item'ı recursive serialize et
        return [serialize_alarm(item) for item in alarm]
    elif isinstance(alarm, (str, int, float, bool, type(None))):
        # Basit tipler olduğu gibi döndür
        return alarm
    else:
        # Diğer tipler için string'e çevir
        return str(alarm)


def serialize_production_consumption(doc: Any) -> Any:
    """MongoDB production_consumption dokümanını serialize eder"""
    if isinstance(doc, ObjectId):
        return str(doc)
    elif isinstance(doc, datetime):
        return doc.isoformat()
    elif isinstance(doc, dict):
        result = {}
        for key, value in doc.items():
            if key == "_id":
                result["id"] = str(value)
            elif key == "date" and isinstance(value, datetime):
                result["date"] = value.isoformat()
            elif key in ["createdAt", "updatedAt"] and isinstance(value, datetime):
                result[key] = value.isoformat()
            else:
                result[key] = serialize_production_consumption(value)
        return result
    elif isinstance(doc, list):
        return [serialize_production_consumption(item) for item in doc]
    elif isinstance(doc, (str, int, float, bool, type(None))):
        return doc
    else:
        return str(doc)


# ---- Routes ----

@app.get("/health")
async def health_check():
    return {"status": "ok"}


@app.get("/api/v1/debug/routes")
async def debug_routes():
    """Tüm yüklü route'ları listeler (debug için)"""
    routes = []
    for route in app.routes:
        if hasattr(route, 'methods') and hasattr(route, 'path'):
            routes.append({
                "path": route.path,
                "methods": list(route.methods) if route.methods else []
            })
    return {"routes": routes}


@app.post("/api/v1/auth/login", response_model=LoginResponse)
async def login(req: LoginRequest):
    try:
        # 1. Kullanıcıyı email'e göre bul
        user = users_collection.find_one({"email": req.email})
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500, 
                detail="MongoDB izin hatası: Kullanıcının 'find' işlemi yapma yetkisi yok. MongoDB Atlas'ta kullanıcı izinlerini kontrol edin."
            )
        raise HTTPException(status_code=500, detail=f"MongoDB bağlantı hatası: {error_msg}")
    
    if not user:
        raise HTTPException(status_code=401, detail="Email veya şifre hatalı")

    # 2. Şifreyi bcrypt ile kontrol et
    stored_password = user.get("password")
    
    # Eski kullanıcılar için backward compatibility (düz metin şifre)
    if stored_password and (stored_password.startswith("$2b$") or stored_password.startswith("$2a$")):
        # Hash'lenmiş şifre kontrolü
        if not bcrypt.checkpw(req.password.encode('utf-8'), stored_password.encode('utf-8')):
            raise HTTPException(status_code=401, detail="Email veya şifre hatalı")
    else:
        # Eski düz metin şifre kontrolü (backward compatibility)
        if stored_password != req.password:
            raise HTTPException(status_code=401, detail="Email veya şifre hatalı")

    # 3. JWT token üret
    payload = {
        "userId": str(user["_id"]),
        "email": user["email"],
        "exp": datetime.utcnow() + timedelta(days=7),
    }
    token = jwt.encode(payload, JWT_SECRET, algorithm="HS256")

    # 4. userName değerini belirle (name varsa onu, yoksa email)
    name = user.get("name") or user["email"]
    
    # 5. Yeni field'ları al
    phone = user.get("phone")
    company = str(user.get("company")) if user.get("company") else None
    user_type = user.get("userType")

    return LoginResponse(
        token=token, 
        userName=name,
        phone=phone,
        company=company,
        userType=user_type
    )


@app.get("/api/v1/alarms")
async def get_alarms(format: str = Query("array", description="Response format: 'array' or 'wrapper'")):
    """
    Alarms listesini döndürür.
    
    Query parametreleri:
    - format: 'array' (varsayılan) veya 'wrapper'
      - 'array': Direkt array döner
      - 'wrapper': { "data": [...], "alarms": [...] } formatında döner
    """
    try:
        # MongoDB'den tüm alarmları çek
        alarms = list(alarms_collection.find())
        
        # Her alarmı serialize et
        serialized_alarms = [serialize_alarm(alarm) for alarm in alarms]
        
        # Format'a göre response döndür
        if format == "wrapper":
            return {
                "data": serialized_alarms,
                "alarms": serialized_alarms
            }
        else:
            return serialized_alarms
            
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500, 
                detail="MongoDB izin hatası: Kullanıcının 'find' işlemi yapma yetkisi yok. MongoDB Atlas'ta kullanıcı izinlerini kontrol edin."
            )
        raise HTTPException(status_code=500, detail=f"Alarms çekilirken hata oluştu: {error_msg}")


# ---- Production Consumption Routes ----

@app.get("/api/v1/production-consumption/daily", response_model=ProductionConsumptionResponse)
async def get_daily_production_consumption(
    date: str = Query(..., description="Tarih (ISO format: YYYY-MM-DD veya YYYY-MM-DDTHH:MM:SS)")
):
    """
    Belirli bir tarih için günlük üretim ve tüketim verilerini getirir.
    
    Query parametreleri:
    - date: Tarih (ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z")
    """
    try:
        # Tarihi parse et
        try:
            if "T" in date:
                date_obj = datetime.fromisoformat(date.replace("Z", "+00:00"))
            else:
                date_obj = datetime.strptime(date, "%Y-%m-%d")
        except ValueError:
            raise HTTPException(status_code=400, detail="Geçersiz tarih formatı. YYYY-MM-DD veya ISO format kullanın.")
        
        # Tarihin başlangıcını al (00:00:00)
        date_start = date_obj.replace(hour=0, minute=0, second=0, microsecond=0)
        date_end = date_start + timedelta(days=1)
        
        # MongoDB'den veriyi çek
        doc = production_consumption_collection.find_one({
            "date": {
                "$gte": date_start,
                "$lt": date_end
            }
        })
        
        if not doc:
            raise HTTPException(status_code=404, detail=f"{date} tarihi için veri bulunamadı.")
        
        # Serialize et
        serialized = serialize_production_consumption(doc)
        
        # Net consumption hesapla (eğer yoksa)
        if "netConsumption" not in serialized:
            serialized["netConsumption"] = serialized.get("dailyConsumption", 0) - serialized.get("dailyProduction", 0)
        
        return serialized
        
    except HTTPException:
        raise
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500,
                detail="MongoDB izin hatası: Kullanıcının 'find' işlemi yapma yetkisi yok."
            )
        raise HTTPException(status_code=500, detail=f"Veri çekilirken hata oluştu: {error_msg}")


@app.get("/api/v1/production-consumption/latest", response_model=ProductionConsumptionResponse)
async def get_latest_production_consumption():
    """
    En son eklenen günlük üretim ve tüketim verisini getirir.
    """
    try:
        # MongoDB'den en son veriyi çek (date'e göre descending sırala)
        doc = production_consumption_collection.find_one(
            sort=[("date", -1)]
        )
        
        if not doc:
            raise HTTPException(status_code=404, detail="Veri bulunamadı.")
        
        # Serialize et
        serialized = serialize_production_consumption(doc)
        
        # Net consumption hesapla (eğer yoksa)
        if "netConsumption" not in serialized:
            serialized["netConsumption"] = serialized.get("dailyConsumption", 0) - serialized.get("dailyProduction", 0)
        
        return serialized
        
    except HTTPException:
        raise
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500,
                detail="MongoDB izin hatası: Kullanıcının 'find' işlemi yapma yetkisi yok."
            )
        raise HTTPException(status_code=500, detail=f"Veri çekilirken hata oluştu: {error_msg}")


@app.post("/api/v1/production-consumption", response_model=ProductionConsumptionResponse)
async def create_production_consumption(req: ProductionConsumptionRequest):
    """
    Yeni günlük üretim ve tüketim verisi ekler.
    
    Body:
    - date: Tarih (ISO format: "2025-12-14T00:00:00.000Z")
    - dailyConsumption: Günlük tüketim (kWh)
    - dailyProduction: Günlük üretim (kWh)
    - buildingId: Bina ID (opsiyonel)
    - analyzerId: Analizör ID (opsiyonel)
    """
    try:
        # Tarihi parse et
        try:
            if "T" in req.date:
                date_obj = datetime.fromisoformat(req.date.replace("Z", "+00:00"))
            else:
                date_obj = datetime.strptime(req.date, "%Y-%m-%d")
            date_obj = date_obj.replace(hour=0, minute=0, second=0, microsecond=0)
        except ValueError:
            raise HTTPException(status_code=400, detail="Geçersiz tarih formatı. YYYY-MM-DD veya ISO format kullanın.")
        
        # Net consumption hesapla
        net_consumption = req.dailyConsumption - req.dailyProduction
        
        # MongoDB document oluştur
        doc = {
            "date": date_obj,
            "dailyConsumption": req.dailyConsumption,
            "dailyProduction": req.dailyProduction,
            "netConsumption": net_consumption,
            "createdAt": datetime.utcnow(),
            "updatedAt": datetime.utcnow(),
        }
        
        # Opsiyonel alanları ekle
        if req.buildingId:
            doc["buildingId"] = req.buildingId
        if req.analyzerId:
            doc["analyzerId"] = req.analyzerId
        
        # MongoDB'ye ekle
        result = production_consumption_collection.insert_one(doc)
        
        # Eklenen dokümanı çek
        inserted_doc = production_consumption_collection.find_one({"_id": result.inserted_id})
        
        if not inserted_doc:
            raise HTTPException(status_code=500, detail="Veri eklenirken hata oluştu.")
        
        # Serialize et
        serialized = serialize_production_consumption(inserted_doc)
        
        return serialized
        
    except HTTPException:
        raise
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500,
                detail="MongoDB izin hatası: Kullanıcının 'insert' işlemi yapma yetkisi yok."
            )
        raise HTTPException(status_code=500, detail=f"Veri eklenirken hata oluştu: {error_msg}")


# ---- Device Token Routes ----

# Debug: Bu endpoint'in yüklendiğini kontrol et
print("=" * 50)
print("🔔 Device Token endpoint'leri yükleniyor...")
print("=" * 50)

@app.post("/api/v1/notifications/device/save", response_model=DeviceTokenResponse)
async def save_device_token(req: DeviceTokenRequest):
    """
    FCM device token'ı kaydeder veya günceller.
    """
    try:
        # Mevcut token'ı kontrol et
        existing = device_tokens_collection.find_one({
            "userId": req.userId,
            "fcmToken": req.fcmToken
        })
        
        if existing:
            # Token zaten varsa güncelle
            device_tokens_collection.update_one(
                {"userId": req.userId, "fcmToken": req.fcmToken},
                {
                    "$set": {
                        "platform": req.platform,
                        "updatedAt": datetime.utcnow()
                    }
                }
            )
            return DeviceTokenResponse(success=True, message="Token güncellendi.")
        else:
            # Yeni token ekle
            doc = {
                "userId": req.userId,
                "fcmToken": req.fcmToken,
                "platform": req.platform,
                "createdAt": datetime.utcnow(),
                "updatedAt": datetime.utcnow()
            }
            device_tokens_collection.insert_one(doc)
            return DeviceTokenResponse(success=True, message="Token kaydedildi.")
            
    except HTTPException:
        raise
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500,
                detail="MongoDB izin hatası: Kullanıcının 'insert' veya 'update' işlemi yapma yetkisi yok."
            )
        raise HTTPException(status_code=500, detail=f"Token kaydedilirken hata oluştu: {error_msg}")


@app.post("/api/v1/notifications/device/delete", response_model=DeviceTokenResponse)
async def delete_device_token(req: DeviceTokenDeleteRequest):
    """
    FCM device token'ı siler.
    """
    try:
        result = device_tokens_collection.delete_one({
            "userId": req.userId,
            "fcmToken": req.fcmToken
        })
        
        if result.deleted_count > 0:
            return DeviceTokenResponse(success=True, message="Token silindi.")
        else:
            return DeviceTokenResponse(success=False, message="Token bulunamadı.")
            
    except Exception as e:
        error_msg = str(e)
        if "not allowed" in error_msg or "AtlasError" in error_msg:
            raise HTTPException(
                status_code=500,
                detail="MongoDB izin hatası: Kullanıcının 'delete' işlemi yapma yetkisi yok."
            )
        raise HTTPException(status_code=500, detail=f"Token silinirken hata oluştu: {error_msg}")
