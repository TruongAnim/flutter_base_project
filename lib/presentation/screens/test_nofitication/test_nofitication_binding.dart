import 'package:get/get.dart';

import 'test_nofitication_controller.dart';

class TestNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestNotificationController>(TestNotificationController());
  }
}
