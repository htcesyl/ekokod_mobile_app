
class ApiConfig {
  /// Şimdilik local backend için:
  /// - Android emülatör: 10.0.2.2
  /// - iOS simulator / web: localhost
  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';
}



class AuthEndpoints {
  static const String login = '/auth/login';
}

class AnalyticsEndpoints {
  static const String consumption = '/analytics/consumption';
  static const String billMetrics = '/analytics/bill-metrics';
  static const String carbonFootprint = '/analytics/carbon-footprint';
}

class NotificationEndpoints {
  static const String list = '/notifications';
  static const String markRead = '/notifications/read';
}

class AlarmEndpoints {
  static const String list = '/alarms';
}

class BuildingEndpoints {
  static const String list = '/building';
}

class AnalyzerEndpoints {
  static const String list = '/analyzer';
}

class ConsumptionEndpoints {
  static const String list = '/consumption';
}

class ProductionConsumptionEndpoints {
  static const String daily = '/production-consumption/daily';
  static const String latest = '/production-consumption/latest';
  static const String create = '/production-consumption';
}