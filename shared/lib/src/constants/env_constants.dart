import '../../shared.dart';

class EnvConstants {
  const EnvConstants._();

  static const flavorKey = 'FLAVOR';
  static const appBasicAuthNameKey = 'APP_BASIC_AUTH_NAME';
  static const appBasicAuthPasswordKey = 'APP_BASIC_AUTH_PASSWORD';

  static late Flavor flavor =
      Flavor.values.byName(const String.fromEnvironment(flavorKey, defaultValue: 'develop'));
  static late String appBasicAuthName = const String.fromEnvironment(appBasicAuthNameKey);
  static late String appBasicAuthPassword = const String.fromEnvironment(appBasicAuthPasswordKey);

  static void init() {
    Log.d(flavor, name: flavorKey);
    Log.d(appBasicAuthName, name: appBasicAuthNameKey);
    Log.d(appBasicAuthPassword, name: appBasicAuthPasswordKey);
  }
}
