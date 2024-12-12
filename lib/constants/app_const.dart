import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

enum BuildType {
  product,
  tester,
  debug,
}

mixin AppConst {
  static const int pageSize = 10;
  static const int pageDefault = 1;
  static const String pathImage = 'resources';
  static const String pathAssets = 'assets';
  static const bool useDebugAds = true;
  static const supportLanguages = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('pt', 'PT'),
    Locale('id', 'ID'),
    Locale('th', 'TH'),
    Locale('hi', 'HI'),
    Locale('ar', 'AR'),
    Locale('de', 'DE'),
    Locale('fr', 'FR'),
    Locale('vi', 'VN'),
    Locale('ko', 'KR'),
    Locale('ja', 'JP'),
    Locale('zh', 'CN'),
  ];
  static const policyUrl = "https://reelbox.me/privacy_policy";
  static const termUrl = "https://reelbox.me/term_of_user";
  static const userAgreement = "https://reelbox.me/term_of_user";

  // Cái này có thể thay đổi
  static bool loginFacebook = true;
  static bool loginGoogle = true;
  static bool loginApple = true;
  static int cacheShort = 0;
  static int cacheFilm = 1;

  static bool defaultDiscovery = true;

  // Show tester log chỉ dùng trong tester build
  static bool showTesterLog = false;

  // In tester list
  static bool inTesterList = false;

  // **build_check**
  static const BuildType buildType = BuildType.tester;

  static const String kEmailSupport = "feedback@reelbox.me";
  static const String appStoreId = 'id6677011128';
  static const String packageName = 'ngx.short.drama.movie';
  static const double defaultAspectRatio = 9 / 16;
  static const double thumbAspectRatio = 12 / 17;
  static const String fbAppId = '551304034313740';
  // **build_check**
  // Version để update app.
  // Không bị ảnh hưởng với build version của android hay ios
  static const int currentVersion = 1;

  static const String notiChannelId = 'channel';
  static List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];
}
