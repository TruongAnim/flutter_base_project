import 'package:get/get.dart';

import 'test_short_controller.dart';

class TestShortBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestShortController>(TestShortController());
  }
}
