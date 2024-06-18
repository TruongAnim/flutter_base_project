import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/services/notification_service/local_notification_service.dart';
import 'package:get/get.dart';

class TestNotificationController extends GetxController {
  LocalNotificationService localNotificationService =
      appGlobal<LocalNotificationService>();
  void requestPermission() {
    localNotificationService.configNotification();
  }

  void showNoti() {
    localNotificationService.showNotification();
  }
}
