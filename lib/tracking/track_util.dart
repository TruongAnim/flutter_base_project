import 'package:flutter_base_project/core/global/auth_controller.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_base_project/core/shared_preference/shared_pref.dart';

import '../constants/app_const.dart';
import '../core/global/exports.dart';

class TrackUtil {
  static const String _eventScreen = "event_screen";
  static const String _userId = "account_id";
  static const String _isPro = "is_pro";
  static const String _isLogin = "is_login";
  static const String _adsId = "ads_id";
  static const String _activeDay = "active_day";
  static const String _appOpen = "app_open";
  static const String _daySinceInstall = "day_since_install";
  static const String _buildType = "build_type";
  static const String _appRunTime = "app_run_time";
  static const String _locale = "locale";

  static void init() async {
    if (SharedPref.I.getAppOpen == 0) {
      SharedPref.I.setFirstOpen(now.millisecondsSinceEpoch);
    }
    SharedPref.I.setAppOpen(SharedPref.I.getAppOpen + 1);

    FirebaseAnalytics.instance
        .setUserProperty(name: _buildType, value: AppConst.buildType.name);
    FirebaseAnalytics.instance.setUserProperty(
        name: _appOpen, value: SharedPref.I.getAppOpen.toString());
    FirebaseAnalytics.instance.setUserProperty(
        name: _activeDay, value: _getListActiveDay().toString());
    FirebaseAnalytics.instance.setUserProperty(
        name: _daySinceInstall, value: _getDaySinceInstall().toString());
    FirebaseAnalytics.instance
        .setUserProperty(name: _locale, value: SharedPref.I.getLocale);
    FirebaseAnalytics.instance
        .setUserProperty(name: _adsId, value: await DeviceUtil.getAdsId());
  }

  static int _getDaySinceInstall() {
    return DateTime.now()
        .difference(
            DateTime.fromMillisecondsSinceEpoch(SharedPref.I.getFirstOpen))
        .inDays;
  }

  static int _getListActiveDay() {
    List<String> activeDays = SharedPref.I.getActiveDay;
    if (!activeDays.contains(DateTimeUtil.formatDate(now))) {
      activeDays.add(DateTimeUtil.formatDate(now));
      SharedPref.I.setActiveDay(activeDays);
    }
    return activeDays.length;
  }

  static void updateUserInfo() {
    FirebaseAnalytics.instance.setUserProperty(
        name: _userId, value: appGlobal<AuthController>().user.value?.id);
  }

  static void logEvent(
      String eventName, String screen, Map<String, dynamic> parameters) {
    parameters.addEntries({
      _appRunTime: RuntimeUtil.appRunTime,
      _eventScreen: screen,
    }.entries);
    parameters = parameters.map((key, value) {
      if (value == null) {
        return MapEntry(key, 'null');
      }
      if (value is Enum) {
        return MapEntry(key, value.name);
      }
      if (value is num) {
        return MapEntry(key, value);
      }
      return MapEntry(key, value.toString());
    });
    FirebaseAnalytics.instance
        .logEvent(name: eventName, parameters: parameters.cast());
  }

  static void logEventRaw(String eventName, Map<String, dynamic> parameters) {
    FirebaseAnalytics.instance
        .logEvent(name: eventName, parameters: parameters.cast());
  }
}
