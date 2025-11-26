
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveDeviceToken({
    required String userId,
    required String fcmToken,
    required String platform,
  }) {
    return remoteDataSource.saveDeviceToken(
      userId: userId,
      fcmToken: fcmToken,
      platform: platform,
    );
  }

  @override
  Future<void> deleteDeviceToken({
    required String userId,
    required String fcmToken,
  }) {
    return remoteDataSource.deleteDeviceToken(
      userId: userId,
      fcmToken: fcmToken,
    );
  }
}
