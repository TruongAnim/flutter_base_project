import 'dart:convert';
import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../shared_preference/exports.dart';

class DeviceInfo {
  String id;
  String name;
  String platform;
  String osVersion;

  DeviceInfo(this.id, this.name, this.platform, this.osVersion);
}

class DeviceUtil {
  static late bool isAndroid;
  static late bool isIos;
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;
  static PackageInfo? packageInfo;
  static String deviceId = '';

  static String get appVersion => packageInfo?.version ?? '1.0.0';
  static String get buildVersion => packageInfo?.buildNumber ?? '1';

  static Future<void> initialize() async {
    isAndroid = Platform.isAndroid;
    isIos = Platform.isIOS;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (isIos) {
      iosInfo = await deviceInfo.iosInfo;
    }
    await _initDeviceId();
    packageInfo = await PackageInfo.fromPlatform();
  }

  static Future<void> _initDeviceId() async {
    deviceId = SharedPref.instance.getDeviceId;
    if (deviceId.isEmpty) {
      String udid = await getUdid();
      if (isAndroid) {
        deviceId = await getAndroidDeviceId(udid);
      } else if (isIos) {
        deviceId = await getIosDeviceId(udid);
      }
      SharedPref.instance.setDeviceId(deviceId);
    }
  }

  static Future<bool> isNetworkConnected() async {
    final connectivityResult = await getNetworkState();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  static Future<ConnectivityResult> getNetworkState() async {
    return await Connectivity().checkConnectivity();
  }

  static bool isEnableConnectStatus(ConnectivityResult status) {
    return (status == ConnectivityResult.mobile) ||
        (status == ConnectivityResult.wifi);
  }

  static bool isEnableListConnectStatus(List<ConnectivityResult> statusList) {
    return (statusList.contains(ConnectivityResult.mobile)) ||
        (statusList.contains(ConnectivityResult.wifi));
  }

  static Future<String?> getAdsId() async {
    return AdvertisingId.id(true);
  }

  static Future<String> getAndroidDeviceId(String defaultDeviceId) async {
    // Sử dụng ads id của google -> K đổi, unique
    // androidInfo?.id -> K đổi nhưng có thể k unique. Các device trùng nhau
    final advertisingId = await getAdsId();
    return _formatId(
        '${advertisingId}_${androidInfo?.product}_${androidInfo?.id}_$defaultDeviceId');
  }

  static Future<String> getIosDeviceId(String defaultDeviceId) async {
    // Ads id sẽ bị null khi người dùng từ chối AppTrackingTransparency -> K thể dùng
    // iosInfo?.identifierForVendor sẽ thay đổi mỗi khi xóa app cài lại. -> K thể dùng
    return _formatId('${iosInfo?.name}_${iosInfo?.model}_$defaultDeviceId');
  }

  static Future<String> getUdid() async {
    // Unique deviceId from 3th party lib.
    // Add this to make sure deviceId will be unique.
    // Android use Settings.Secure.ANDROID_ID
    // Ios use identifierForVendor then save to Keychain to make it unchange when uninstall
    // Pod update can make FlutterUdid.udid return different value
    return await FlutterUdid.udid;
  }

  static String _formatId(String content) {
    // Encode id về chung 1 format.
    return sha256.convert(utf8.encode(content)).toString();
  }

  static DeviceInfo getDeviceInfo() {
    if (isAndroid) {
      return DeviceInfo(
        deviceId,
        androidInfo!.model,
        "android",
        androidInfo!.version.release,
      );
    } else if (isIos) {
      return DeviceInfo(
        deviceId,
        iosInfo!.model,
        'ios',
        iosInfo!.systemVersion,
      );
    }
    return DeviceInfo('null', 'null', '', '');
  }
}
