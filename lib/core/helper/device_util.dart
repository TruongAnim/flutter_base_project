import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

mixin DeviceUtil {
  static late bool isAndroid;
  static late bool isIos;
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;

  static void initialize() async {
    isAndroid = Platform.isAndroid;
    isIos == Platform.isIOS;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (isIos) {
      iosInfo = await deviceInfo.iosInfo;
    }
  }
}
