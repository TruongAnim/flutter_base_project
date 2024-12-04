import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_base_project/core/helper/exports.dart';

mixin FirebaseNotificationService {
  static const String tag = 'FirebaseNotificationService';

  static Future<void> init() async {
    // Setup firebase services.
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    // Get device token.
    String? deviceToken = '';
    try {
      deviceToken = await messaging.getToken();
      appLog(tag: tag, msg: 'Device id: $deviceToken');
      // appGlobal<SharedPreferenceHelper>().setTokenDevice(_deviceToken.toString());
    } catch (e, s) {
      appLog(tag: tag, msg: 'Error get device token at $e and $s');
    }
  }
}
