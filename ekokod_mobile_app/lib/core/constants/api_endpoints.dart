class ApiEndpoints {
  ApiEndpoints._();

  // ✅ Tüm endpointlerin temel aldığı ana URL
  static const String baseUrl = 'https://senin-api-adresin.com';

  static const String login = '$baseUrl/auth/login';
  static const String getBills = '$baseUrl/bills';

  // ✅ Yeni eklediklerimiz
  static const String saveDeviceToken = '$baseUrl/notifications/device/save';
  static const String deleteDeviceToken = '$baseUrl/notifications/device/delete';
}
