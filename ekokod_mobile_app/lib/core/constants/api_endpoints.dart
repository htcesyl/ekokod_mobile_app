import '../network/endpoints.dart';

class ApiEndpoints {
  ApiEndpoints._();

  // ✅ Device token endpoint'leri - endpoints.dart'taki ApiConfig.baseUrl kullanıyor
  static String get saveDeviceToken => '${ApiConfig.baseUrl}/notifications/device/save';
  static String get deleteDeviceToken => '${ApiConfig.baseUrl}/notifications/device/delete';
}
