import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

mixin CrashlyticsService {
  static Future<void> init() async {
    if (kDebugMode) {
      // Không gửi crash log ở debug mode
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterError(
          details,
          fatal: !(details.exception is HttpException ||
              details.exception is SocketException ||
              details.exception is HandshakeException ||
              details.exception is ClientException),
        );
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: !(error is HttpException ||
              error is SocketException ||
              error is HandshakeException ||
              error is ClientException),
        );
        return true;
      };
    }
  }
}
