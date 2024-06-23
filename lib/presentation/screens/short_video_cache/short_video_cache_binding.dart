import 'package:get/get.dart';

import 'short_video_cache_controller.dart';

class ShortVideoCacheBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShortVideoCacheController>(ShortVideoCacheController());
  }
}
