import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
class NotificationData with _$NotificationData {
  const NotificationData._();

  const factory NotificationData({
    @JsonKey(name: 'notification_id') String? notificationId,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'notification_type') String? notificationType,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);
}
