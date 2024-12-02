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
    return _sharedPreference.getString(PrefKey.isShowClickerGuide) ?? '';
  }

  Future<bool> setJwtToken(String token) {
    return _sharedPreference.setString(PrefKey.isShowClickerGuide, token);
  }

  String get getDeviceId {
    return _sharedPreference.getString(PrefKey.deviceId) ?? '';
  }

  Future<bool> setDeviceId(String deviceId) async {
    return _sharedPreference.setString(PrefKey.deviceId, deviceId);
  }
}
