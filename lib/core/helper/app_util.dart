import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import '../shared_preference/exports.dart';

get now => DateTime.now();

appLog({String? tag, dynamic msg}) {
  if (kDebugMode) {
    print('AppLog($now):[$tag] $msg');
  }
}

get appLocal {
  return SharedPref.instance.getLocale;
}

bool nullOrEmpty(dynamic value) {
  if (value == null ||
      value.toString().trim().isEmpty ||
      value.toString() == 'null' ||
      value.toString() == '{}' ||
      (value is List && value.isEmpty == true)) return true;
  return false;
}

bool notNullOrEmpty(dynamic value) {
  return !nullOrEmpty(value);
}

class AppUtil {
  static Future<void> addVibration({required Function callback}) async {
    HapticFeedback.lightImpact();
    callback();
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> getCountryByIp() async {
    try {
      final response = await http
          .get(Uri.parse('https://ipinfo.io/country'))
          .timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        return response.body.toString().replaceAll(RegExp(r'\s+'), '');
      } else {
        return null;
      }
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  static double max(double a, double b) {
    return math.max(a, b);
  }

  static double min(double a, double b) {
    return math.min(a, b);
  }

  // Regular expression for URL validation
  static final RegExp _urlRegExp =
      RegExp(r'^(https?:\/\/)?' // Protocol (optional)
          r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}' // Domain name and extension
          r'(:[0-9]{1,5})?' // Port (optional)
          );

  // Static method to validate the URL
  static bool isValidLink(String url) {
    return _urlRegExp.hasMatch(url);
  }

  static String getFirstChars(String input, [int length = 50]) {
    if (input.length > length) {
      return input.substring(0, length);
    } else {
      return input;
    }
  }
}
