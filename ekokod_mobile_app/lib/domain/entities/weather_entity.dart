// lib/domain/entities/weather_entity.dart (DÜZELTİLMİŞ KOD)

import 'package:freezed_annotation/freezed_annotation.dart';

// DİKKAT 1: Bu satır, üretilecek dosyanın adını belirtir.
// Eğer bu dosya 'weather_entity.dart' ise, üretilecek dosya da '.freezed.dart' ile bitmelidir.
part 'weather_entity.freezed.dart'; 

@freezed
// DİKKAT 2: Sınıf tanımı, sadece Freezed'dan kalıtım almalıdır.
// mixin kullanmıyoruz, sadece 'with _$WeatherEntity' gibi yanlış ifadeler kullanmıyoruz.
class WeatherEntity with _$WeatherEntity {
  const factory WeatherEntity({
    required double currentTemperature, // Santigrat cinsinden sıcaklık
    required double windSpeed,
    // Diğer alanlar buraya eklenir
  }) = _WeatherEntity; // ⬅️ Bu yapıyı koruyoruz
}

// DİKKAT 3: Eğer JSON serileştirme de kullanıyorsanız bu satırı ekleyin:
 factory WeatherEntity.fromJson(Map<String, dynamic> json) => _$WeatherEntityFromJson(json);