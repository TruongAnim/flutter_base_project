import 'package:get/get.dart';

import 'list_post_controller.dart';

class ListPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ListPostController>(ListPostController());
  }
}
