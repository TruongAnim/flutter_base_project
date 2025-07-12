import 'package:shared_preferences/shared_preferences.dart';

import 'pref_key.dart';

class SharedPref {
  SharedPref._privateConstructor();
  static final SharedPref _instance = SharedPref._privateConstructor();
  static SharedPref get instance => _instance;
  static SharedPref get I => _instance;

  late final SharedPreferences _sharedPreference;
  Future<void> init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  // check user rated app or not.
  bool get getIsRatedApp {
    return _sharedPreference.getBool(PrefKey.isRatedApp) ?? false;
  }

  Future<bool> setIsRatedApp({required bool isRate}) {
    return _sharedPreference.setBool(PrefKey.isRatedApp, isRate);
  }

  // check this is the first time user open app
  bool get getIsFirstOpen {
    return _sharedPreference.getBool(PrefKey.isFirstOpen) ?? true;
  }

  Future<bool> setIsFirstOpen({required bool isFirst}) {
    return _sharedPreference.setBool(PrefKey.isFirstOpen, isFirst);
  }

  String get getLocale {
    return _sharedPreference.getString(PrefKey.locale) ?? '';
  }

  Future<bool> setLocale(String locale) {
    return _sharedPreference.setString(PrefKey.locale, locale);
  }

  String get getJwtToken {
    return _sharedPreference.getString(PrefKey.jwtToken) ?? '';
  }

  Future<bool> setJwtToken(String token) {
    return _sharedPreference.setString(PrefKey.jwtToken, token);
  }

  String get getDeviceId {
    return _sharedPreference.getString(PrefKey.deviceId) ?? '';
  }

  Future<bool> setDeviceId(String deviceId) async {
    return _sharedPreference.setString(PrefKey.deviceId, deviceId);
  }

  String get getFcmToken {
    return _sharedPreference.getString(PrefKey.fcmToken) ?? '';
  }

  Future<bool> setFcmToken(String fcmToken) async {
    return _sharedPreference.setString(PrefKey.fcmToken, fcmToken);
  }

  int get getAppOpen {
    return _sharedPreference.getInt(PrefKey.appOpen) ?? 0;
  }

  Future<bool> setAppOpen(int appOpen) async {
    return _sharedPreference.setInt(PrefKey.appOpen, appOpen);
  }

  int get getDaySinceInstall {
    return _sharedPreference.getInt(PrefKey.daySinceInstall) ?? 0;
  }

  Future<bool> setDaySinceInstall(int daySinceInstall) async {
    return _sharedPreference.setInt(PrefKey.daySinceInstall, daySinceInstall);
  }

  List<String> get getActiveDay {
    return _sharedPreference.getStringList(PrefKey.activeDay) ?? [];
  }

  Future<bool> setActiveDay(List<String> activeDay) async {
    return _sharedPreference.setStringList(PrefKey.activeDay, activeDay);
  }

  int get getFirstOpen {
    return _sharedPreference.getInt(PrefKey.firstOpen) ?? 0;
  }

  Future<bool> setFirstOpen(int firstOpen) async {
    return _sharedPreference.setInt(PrefKey.firstOpen, firstOpen);
  }
}
