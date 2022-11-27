// import 'package:firebase_core/firebase_core.dart';
import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';

import '../app.dart';
import '../di/di.dart' as di;

class AppConfig extends ApplicationConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    // await Firebase.initializeApp();
    di.getIt.registerSingleton<AppRouter>(AppRouter());
    await di.configureInjection();
    // Bloc.observer = AppBlocObserver();
    await ViewUtils.setPreferredOrientations(DeviceUtils.deviceType == DeviceType.mobile
        ? UiConstants.mobileOrientation
        : UiConstants.tabletOrientation);
    ViewUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
    await LocalPushNotificationHelper.init();
  }
}
