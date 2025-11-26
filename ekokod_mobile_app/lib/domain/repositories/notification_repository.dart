
abstract class NotificationRepository {
  /// Cihazın FCM token'ını backend'e kaydeder / günceller.
  Future<void> saveDeviceToken({
    required String userId,
    required String fcmToken,
    required String platform, 
  });

  ///  logout sırasında token silmek için.
  Future<void> deleteDeviceToken({
    required String userId,
    required String fcmToken,
  });
}
