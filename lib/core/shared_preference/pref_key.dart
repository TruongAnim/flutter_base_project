class PrefKey {
  PrefKey._();

  // Token
  static const String deviceId = "deviceId";
  static const String fcmToken = "fcmToken";
  static const String jwtToken = "jwtToken";

  // Tracking
  // This is the nth time opening the app.
  static const String appOpen = "appOpen";
  // This is the nth day since the first time opening the app.
  static const String daySinceInstall = "daySinceInstall";
  // This is the nth day using the app.
  static const String activeDay = "activeDay";

  // App
  static const String isFirstOpen = "isFirstOpen";
  static const String firstOpen = "firstOpen";
  static const String isRatedApp = "isRatedApp";
  static const String locale = "locale";
  static const String isShowSwipeGuide = "isShowSwipeGuide";
  static const String isFirstSoundOpen = "isFirstSoundOpen";
  static const String isPremium = "isPremium";
}
