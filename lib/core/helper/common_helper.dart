import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

appPrint(dynamic s) {
  if (kDebugMode) {
    print('AppLog: $s');
  }
}

get appLocal {
  return appGlobal<SharedPreferenceHelper>().getLocale;
}

extension TranslateExtensions on String? {
  String get tran {
    try {
      final local = CommonHelper.local;
      if (this != null && this!.isNotEmpty) {
        final map = json.decode(this!);
        if (map is Map<String, dynamic>) {
          return map[local] ?? map['en'];
        }
      }
      return '';
    } catch (e) {
      return toString();
    }
  }
}

String? mapToString(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is Map<String, dynamic>) {
    return json.encode(data);
  }
  return data.toString();
}

List<String> toListString(dynamic data) {
  if (data is List) {
    return data.map((e) => mapToString(e) ?? '').toList();
  }
  return [];
}

mixin CommonHelper {
  static String local = 'en';

  static ImageWidget getImageWidget(
      {String? uri, required double width, double? height}) {
    if (uri == null || uri == 'null' || uri.isEmpty) {
      return ImageWidget(AppImages.defaultAvatar,
          width: width, height: height ?? width);
    }
    if (uri.startsWith('/data')) {
      return ImageWidget.file(File(uri), width: width, height: height ?? width);
    }
    if (uri.startsWith('http')) {
      return ImageWidget(uri, width: width, height: height ?? width);
    }
    return ImageWidget(uri, width: width, height: height ?? width);
  }

  static Future<String?> pickAnImage(
      {ImageSource source = ImageSource.gallery}) async {
    final XFile? media =
        await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (media != null && media.path.isNotEmpty) {
      return media.path;
    }
    return null;
  }

  static Future<void> addVibration({required Function callback}) async {
    HapticFeedback.lightImpact();
    callback();
  }

  static String durationToTime(Duration duration, {bool isShowHour = false}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0 && !isShowHour) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static void openUrl(url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  static int getPercent(int a, int b) {
    return min(((a / b) * 100).toInt(), 100);
  }

  static int roundToMultiple(int number, int floor) {
    return (number / floor).floor() * floor;
  }

  static bool containRoute(String routeName) {
    for (var route in Get.routeTree.routes) {
      if (route.name == routeName) {
        return true;
      }
    }
    return false;
  }

  static void backToRoute(String routeName) {
    if (containRoute(routeName)) {
      Get.until((route) => Get.currentRoute == routeName);
    } else {
      Get.back();
    }
  }

  static int startDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 1)
        .millisecondsSinceEpoch;
  }

  static int endDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59)
        .millisecondsSinceEpoch;
  }

  static String getTitleByTime() {
    DateTime now = DateTime.now();
    if ((now.hour > 6 || now.hour == 6) && now.hour < 12) {
      return 'morning_walking';
    }
    if ((now.hour > 12 || now.hour == 12) && now.hour < 18) {
      return 'afternoon_walking';
    }
    if ((now.hour > 18 || now.hour == 18) && now.hour < 22) {
      return 'evening_walking';
    }
    if (((now.hour > 22 || now.hour == 22) && now.hour < 23) ||
        ((now.hour > 0 || now.hour == 0) && now.hour < 6)) {
      return 'night_walking';
    }
    return 'daily_walking'.tr;
  }

  static void callOnDebug(Function f) {
    if (kDebugMode) {
      f();
    }
  }
}
