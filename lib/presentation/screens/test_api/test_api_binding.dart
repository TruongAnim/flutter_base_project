import 'package:get/get.dart';

import 'test_api_controller.dart';

class TestApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestApiController>(TestApiController());
  }
}
