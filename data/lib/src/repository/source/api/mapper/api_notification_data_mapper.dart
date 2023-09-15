import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@Injectable()
class ApiNotificationDataMapper extends BaseDataMapper<ApiNotificationData, AppNotification> {
  @override
  AppNotification mapToEntity(ApiNotificationData? data) {
    return AppNotification(
      notificationId: data?.notificationId ?? AppNotification.defaultNotificationId,
      image: data?.image ?? AppNotification.defaultImage,
      title: data?.title ?? AppNotification.defaultTitle,
      message: data?.message ?? AppNotification.defaultMessage,
    );
  }
}
