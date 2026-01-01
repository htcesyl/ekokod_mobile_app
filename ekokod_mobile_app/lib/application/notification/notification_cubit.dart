// lib/application/notification/notification_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository notificationRepository;
  final FirebaseMessaging _messaging;

  NotificationCubit({
    required this.notificationRepository,
    FirebaseMessaging? firebaseMessaging,
  })  : _messaging = firebaseMessaging ?? FirebaseMessaging.instance,
        super(const NotificationState());

  /// Uygulama tarafında push notification sistemini başlatır:
  /// - Kullanıcıdan bildirim izni ister
  /// - Cihazın FCM token'ını alır
  /// - Token'ı backend'e kaydetmeye çalışır
  /// - Bildirim dinleyicilerini (onMessage, onMessageOpenedApp) kurar
  Future<void> init({required String userId, required String platform}) async {
    emit(state.copyWith(isLoading: true));
    print('🔔 NotificationCubit.init() çağrıldı. userId=$userId, platform=$platform');

    // 1) Kullanıcıdan bildirim izni iste (özellikle iOS için önemli)
    final settings = await _messaging.requestPermission();
    final granted = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!granted) {
      print('🔕 Bildirim izni verilmedi. authorizationStatus=${settings.authorizationStatus}');
      emit(state.copyWith(isPermissionGranted: false, isLoading: false));
      return;
    }

    // 2) FCM token al
    final token = await _messaging.getToken();
    if (token == null) {
      print('⚠️ FCM token alınamadı (null döndü).');
      emit(state.copyWith(isPermissionGranted: true, isLoading: false));
      return;
    }

    print('✅ FCM Token alındı: $token');

    // 3) Token'ı backend'e kaydet (backend hazır değilse hata verse bile app çökmeyecek)
    try {
      await notificationRepository.saveDeviceToken(
        userId: userId,
        fcmToken: token,
        platform: platform,
      );
      print('✅ Device token backend\'e kaydedildi.');
      emit(state.copyWith(isPermissionGranted: true, isLoading: false, error: null));
    } catch (e) {
      // Hata durumunu state'e kaydet
      final errorMessage = e.toString();
      print('⚠️ Device token kaydedilirken hata oluştu: $e');
      emit(state.copyWith(
        isPermissionGranted: true,
        isLoading: false,
        error: errorMessage,
      ));
    }

    // 4) Uygulama açıkken gelen mesajları dinle
    FirebaseMessaging.onMessage.listen(_onMessageReceived);

    // 5) Bildirime tıklayıp uygulama açıldığında
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    emit(state.copyWith(isPermissionGranted: true, isLoading: false));
  }

  /// Uygulama ÖN PLANDA iken gelen bildirimler
  void _onMessageReceived(RemoteMessage message) {
    print('📩 onMessage: Yeni bildirim alındı. id=${message.messageId}');

    final newNotification = NotificationEntity(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: message.data,
      createdAt: DateTime.now(),
    );

    final updatedList = List<NotificationEntity>.from(state.notifications)
      ..insert(0, newNotification);

    emit(state.copyWith(notifications: updatedList));
  }

  /// Bildirime tıklanarak uygulama açıldığında tetiklenir
  void _onMessageOpenedApp(RemoteMessage message) {
    print('📲 onMessageOpenedApp: Bildirime tıklanarak uygulama açıldı. id=${message.messageId}');
    // Burada ileride message.data['route'] ile sayfa yönlendirmesi yapabilirsin.
  }
}
