import 'package:get/get.dart';

import 'short_video_controller.dart';

class ShortVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShortVideoController>(ShortVideoController());
  }
}
