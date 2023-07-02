import 'dart:async';

import 'package:flutter/material.dart';
import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';

import 'app/my_app.dart';
import 'config/app_config.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await AppInitializer(AppConfig.getInstance()).init();
  runApp(const MyApp());
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');

  // report by Firebase Crashlytics here
}
