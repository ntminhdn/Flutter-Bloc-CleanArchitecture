import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data.dart';

@LazySingleton()
class AppPreferences with LogMixin {
  AppPreferences(this._sharedPreference)
      : _encryptedSharedPreferences = EncryptedSharedPreferences(prefs: _sharedPreference);

  final SharedPreferences _sharedPreference;
  final EncryptedSharedPreferences _encryptedSharedPreferences;

  bool get isDarkMode {
    return _sharedPreference.getBool(SharedPreferenceKeys.isDarkMode) ?? false;
  }

  String get deviceToken {
    return _sharedPreference.getString(SharedPreferenceKeys.deviceToken) ?? '';
  }

  String get languageCode => _sharedPreference.getString(SharedPreferenceKeys.languageCode) ?? '';

  bool get isFirstLogin => _sharedPreference.getBool(SharedPreferenceKeys.isFirstLogin) ?? true;

  bool get isFirstLaunchApp =>
      _sharedPreference.getBool(SharedPreferenceKeys.isFirstLaunchApp) ?? true;

  Future<String> get accessToken {
    return _encryptedSharedPreferences.getString(SharedPreferenceKeys.accessToken);
  }

  Future<String> get refreshToken {
    return _encryptedSharedPreferences.getString(SharedPreferenceKeys.refreshToken);
  }

  bool get isLoggedIn {
    final token = _sharedPreference.getString(SharedPreferenceKeys.accessToken) ?? '';

    return token.isNotEmpty;
  }

  PreferenceUserData? get currentUser {
    final user = _sharedPreference.getString(SharedPreferenceKeys.currentUser);
    if (user == null) {
      return null;
    }

    return PreferenceUserData.fromJson(json.decode(user));
  }

  Future<bool> saveLanguageCode(String languageCode) {
    return _sharedPreference.setString(SharedPreferenceKeys.languageCode, languageCode);
  }

  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _sharedPreference.setBool(SharedPreferenceKeys.isFirstLogin, isFirstLogin);
  }

  Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) {
    return _sharedPreference.setBool(SharedPreferenceKeys.isFirstLaunchApp, isFirstLaunchApp);
  }

  Future<void> saveAccessToken(String token) async {
    await _encryptedSharedPreferences.setString(
      SharedPreferenceKeys.accessToken,
      token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    await _encryptedSharedPreferences.setString(
      SharedPreferenceKeys.refreshToken,
      token,
    );
  }

  Future<bool> saveCurrentUser(PreferenceUserData preferenceUserData) {
    return _sharedPreference.setString(
      SharedPreferenceKeys.currentUser,
      json.encode(preferenceUserData),
    );
  }

  Future<bool> saveIsDarkMode(bool isDarkMode) {
    return _sharedPreference.setBool(SharedPreferenceKeys.isDarkMode, isDarkMode);
  }

  Future<bool> saveDeviceToken(String token) {
    return _sharedPreference.setString(SharedPreferenceKeys.deviceToken, token);
  }

  Future<void> clearCurrentUserData() async {
    await Future.wait(
      [
        _sharedPreference.remove(SharedPreferenceKeys.currentUser),
        _sharedPreference.remove(SharedPreferenceKeys.accessToken),
        _sharedPreference.remove(SharedPreferenceKeys.refreshToken),
      ],
    );
  }
}
