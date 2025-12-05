// lib/domain/entities/weather_entity.dart

class WeatherEntity {
  final String city;
  final double temperature; // °C
  final String description; // örn: "Güneşli"

  const WeatherEntity({
    required this.city,
    required this.temperature,
    required this.description,
  });
}

