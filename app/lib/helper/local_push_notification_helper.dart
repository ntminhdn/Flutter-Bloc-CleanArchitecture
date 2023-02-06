import 'dart:io';
import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton()
class LocalPushNotificationHelper with LogMixin {
  static const _channelId = 'jp.flutter.app';
  static const _channelName = 'NFT';
  static const _channelDescription = 'NFT';
  static const _androidDefaultIcon = 'ic_app_logo';
  static const _bitCount = 31;

  int get _randomNotificationId => Random().nextInt(pow(2, _bitCount).toInt() - 1);

  static Future<void> init() async {
    /// Change icon at android\app\src\main\res\drawable\app_icon.png
    const androidInit = AndroidInitializationSettings(_androidDefaultIcon);

    /// don't request permission here
    /// we use firebase_messaging package to request permission instead
    const iOSInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const init = InitializationSettings(android: androidInit, iOS: iOSInit);

    /// init local notification
    await Future.wait([
      FlutterLocalNotificationsPlugin().initialize(
        init,
        // TODO(minh): handle later: onSelectNotification: _onSelectNotification,
      ),
    ]);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.high,
        ));
  }

  Future<void> notify(AppNotification notification) async {
    File? imageFile;
    if (notification.image.isNotEmpty) {
      imageFile = await FileUtils.getImageFileFromUrl(notification.image);
      logD('Downloaded Image File: $imageFile');
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      autoCancel: true,
      enableVibration: true,
      playSound: true,
      styleInformation: imageFile != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(imageFile.path),
              hideExpandedLargeIcon: true,
            )
          : null,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await FlutterLocalNotificationsPlugin()
        .show(
          _randomNotificationId,
          notification.title,
          notification.message,
          platformChannelSpecifics,
          // TODO(minh): handle later payload: jsonEncode(data),
        )
        .onError((error, stackTrace) => logE('Can not show notification cause $error'));
  }
}
