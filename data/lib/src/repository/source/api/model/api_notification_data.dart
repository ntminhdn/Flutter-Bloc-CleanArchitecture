import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_notification_data.freezed.dart';
part 'api_notification_data.g.dart';

@freezed
class ApiNotificationData with _$ApiNotificationData {
  const ApiNotificationData._();

  const factory ApiNotificationData({
    @JsonKey(name: 'notification_id') String? notificationId,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'notification_type') String? notificationType,
  }) = _ApiNotificationData;

  factory ApiNotificationData.fromJson(Map<String, dynamic> json) =>
      _$ApiNotificationDataFromJson(json);
}
