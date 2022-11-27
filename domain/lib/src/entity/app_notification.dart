import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'app_notification.freezed.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    @Default('') String notificationId,
    @Default(NotificationType.unknown) NotificationType notificationType,
    @Default('') String image,
    @Default('') String title,
    @Default('') String message,
  }) = _AppNotification;
}
