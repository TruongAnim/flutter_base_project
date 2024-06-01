import 'package:flutter_base_project/core/helper/common_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

mixin NotificationService {
  static Future<void> init() async {
    // Setup firebase services.
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    // Get device token.
    String? deviceToken = '';
    try {
      deviceToken = await messaging.getToken();
      appPrint('Device id: $deviceToken');
      // appGlobal<SharedPreferenceHelper>().setTokenDevice(_deviceToken.toString());
    } catch (e, s) {
      appPrint('Error get device token at $e and $s');
    }
  }
}
