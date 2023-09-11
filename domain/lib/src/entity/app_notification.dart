import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'app_notification.freezed.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    @Default(AppNotification.defaultNotificationId) String notificationId,
    @Default(AppNotification.defaultNotificationType) NotificationType notificationType,
    @Default(AppNotification.defaultImage) String image,
    @Default(AppNotification.defaultTitle) String title,
    @Default(AppNotification.defaultMessage) String message,
  }) = _AppNotification;

  static const defaultNotificationId = '';
  static const defaultNotificationType = NotificationType.defaultValue;
  static const defaultImage = '';
  static const defaultTitle = '';
  static const defaultMessage = '';
}
