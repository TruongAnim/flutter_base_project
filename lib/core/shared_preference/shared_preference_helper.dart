import 'package:shared_preferences/shared_preferences.dart';

import '../global/exports.dart';
import 'preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference = DiContainer.sharedPreferences;

  // check user rated app or not.
  bool get getIsRatedApp {
    return _sharedPreference.getBool(Preferences.isRatedApp) ?? false;
  }

  void setIsRatedApp({required bool isRate}) {
    _sharedPreference.setBool(Preferences.isRatedApp, isRate);
  }

  // check this is the first time user open app
  bool get getIsFirstOpen {
    return _sharedPreference.getBool(Preferences.isFirstOpen) ?? true;
  }

  void setIsFirstOpen({required bool isFirst}) {
    _sharedPreference.setBool(Preferences.isFirstOpen, isFirst);
  }

  // locale user select for multilanguage
  void setLocale(String locale) {
    _sharedPreference.setString(Preferences.locale, locale);
  }

  String get getLocale {
    return _sharedPreference.getString(Preferences.locale) ?? '';
  }

  String get getJwtToken {
    return _sharedPreference.getString(Preferences.isShowClickerGuide) ?? '';
  }

  void setJwtToken(String token) {
    _sharedPreference.setString(Preferences.isShowClickerGuide, token);
  }
}
