import 'package:get/get.dart';

import 'short_video_preload_controller.dart';

class ShortVideoPreloadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShortVideoPreloadController>(ShortVideoPreloadController());
  }
}
