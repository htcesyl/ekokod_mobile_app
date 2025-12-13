# Backend main.py Değişiklik Önerileri

Yeni users tablosu yapısına göre backend'de yapılması gereken değişiklikler:

## 1. Gerekli Kütüphaneleri Ekle

```python
import bcrypt
```

requirements.txt dosyasına ekleyin:
```
bcrypt>=4.0.0
```

## 2. LoginResponse Modelini Güncelle

```python
class LoginResponse(BaseModel):
    token: str
    userName: str
    phone: str | None = None
    company: str | None = None  # ObjectId string olarak
    userType: str | None = None
```

## 3. Login Endpoint'ini Güncelle

```python
@app.post("/api/v1/auth/login", response_model=LoginResponse)
async def login(req: LoginRequest):
    # 1. Kullanıcıyı email'e göre bul
    user = users_collection.find_one({"email": req.email})
    if not user:
        raise HTTPException(status_code=401, detail="Email veya şifre hatalı")

    # 2. Şifreyi bcrypt ile kontrol et
    stored_password = user.get("password")
    
    # Eski kullanıcılar için backward compatibility (düz metin şifre)
    if stored_password.startswith("$2b$") or stored_password.startswith("$2a$"):
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
```

## Önemli Notlar

1. **Backward Compatibility**: Eski kullanıcıların (ekokod042 ile başlayan) düz metin şifreleri için kontrol eklendi. Yeni kullanıcılar hash'lenmiş şifre kullanacak.

2. **Password Migration**: İsterseniz eski kullanıcıların şifrelerini hash'leyip güncelleyebilirsiniz (opsiyonel).

3. **Company Field**: MongoDB'de ObjectId olarak saklanıyor, response'da string olarak gönderiliyor.

4. **Optional Fields**: phone, company, userType optional olduğu için None olabilir.

