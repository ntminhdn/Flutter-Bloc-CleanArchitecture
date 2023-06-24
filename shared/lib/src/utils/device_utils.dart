import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../../../shared.dart';

class DeviceUtils {
  const DeviceUtils._();
  static late DeviceType deviceType = _getDeviceType();

  static Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      return await FlutterUdid.udid; // unique ID on iOS
    } else {
      const _androidIdPlugin = AndroidId();

      final androidID = await _androidIdPlugin.getId();

      return androidID ?? ''; // unique ID on Android
    }
  }

  static Future<String> getDeviceModelName() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      return iosInfo.name;
    } else {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return '${androidInfo.brand} ${androidInfo.device}';
    }
  }

  static DeviceType _getDeviceType() {
    return MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first)
                .size
                .shortestSide <
            DeviceConstants.maxMobileWidthForDeviceType
        ? DeviceType.mobile
        : DeviceType.tablet;
  }
}
