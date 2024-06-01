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

  // check if show user clicker guide
  bool get getShowClickerGuide {
    return _sharedPreference.getBool(Preferences.isShowClickerGuide) ?? false;
  }

  void setShowClickerGuide(bool isShow) {
    _sharedPreference.setBool(Preferences.isShowClickerGuide, isShow);
  }

  // check if show swipe guide
  bool get getShowSwipeGuide {
    return _sharedPreference.getBool(Preferences.isShowSwipeGuide) ?? false;
  }

  void setShowSwipeGuide(bool isShow) {
    _sharedPreference.setBool(Preferences.isShowSwipeGuide, isShow);
  }

  void setFirstSoundOpen(bool isFristOpen) {
    _sharedPreference.setBool(Preferences.isFirstSoundOpen, isFristOpen);
  }

  bool get getFirstSoundOpen {
    return _sharedPreference.getBool(Preferences.isFirstSoundOpen) ?? true;
  }

  void setPremium(bool isPremium) {
    _sharedPreference.setBool(Preferences.isPremium, isPremium);
  }

  bool get getPremium {
    return _sharedPreference.getBool(Preferences.isPremium) ?? false;
  }
}
