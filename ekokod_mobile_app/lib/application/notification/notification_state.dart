
import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationState extends Equatable {
  final bool isPermissionGranted;
  final bool isLoading;
  final List<NotificationEntity> notifications;

  const NotificationState({
    this.isPermissionGranted = false,
    this.isLoading = false,
    this.notifications = const [],
  });

  NotificationState copyWith({
    bool? isPermissionGranted,
    bool? isLoading,
    List<NotificationEntity>? notifications,
  }) {
    return NotificationState(
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [isPermissionGranted, isLoading, notifications];
}
