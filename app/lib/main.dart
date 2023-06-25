import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';

import 'app/my_app.dart';
import 'config/app_config.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await AppInitializer(AppConfig.getInstance()).init();
  final initialResource = await _loadInitialResource();
  runApp(MyApp(initialResource: initialResource));
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');

  // report by Firebase Crashlytics here
}

Future<LoadInitialResourceOutput> _loadInitialResource() async {
  final result = runCatching(
    action: () =>
        GetIt.instance.get<LoadInitialResourceUseCase>().execute(const LoadInitialResourceInput()),
  );

  return result.when(
    success: (output) => output,
    failure: (e) => const LoadInitialResourceOutput(),
  );
}
