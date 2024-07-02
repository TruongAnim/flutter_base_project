import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

class LogUtil {
  static void v(String? message,
      {String tag = "V", dynamic ex, StackTrace? stacktrace}) {
    if (kDebugMode) {
      print((tag, message));
    }
  }

  static void d(String? message,
      {String tag = "D", dynamic ex, StackTrace? stacktrace}) {
    if (kDebugMode) {
      Fimber.log(tag, message ?? '', ex: ex, stacktrace: stacktrace);
    }
  }

  static void i(String? message,
      {String tag = "I", dynamic ex, StackTrace? stacktrace}) {
    if (kDebugMode) {
      Fimber.log(tag, message ?? '', ex: ex, stacktrace: stacktrace);
    }
  }

  static void w(String? message,
      {String tag = "W", dynamic ex, StackTrace? stacktrace}) {
    if (kDebugMode) {
      Fimber.log(tag, message ?? '', ex: ex, stacktrace: stacktrace);
    }
  }

  static void e(String? message,
      {String tag = "E", dynamic ex, StackTrace? stacktrace}) {
    if (kDebugMode) {
      Fimber.log(tag, message ?? '', ex: ex, stacktrace: stacktrace);
    }
  }
}
