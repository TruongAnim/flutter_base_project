import 'package:flutter_base_project/config/routes/base_routers.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class DashboardController extends GetxController {
  final List<Tuple2<String, Function>> listFunction = [];
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    listFunction.addAll([
      Tuple2('List Post', toListPost),
      Tuple2('Notification', toNotificationPage),
      Tuple2('Short Video', toShortVideoPage),
      Tuple2('Short Video Preload', toShortVideoPreloadPage),
      Tuple2('Short Video Cache', toShortVideoCache),
      Tuple2('Short', toShort),
    ]);
  }

  void toListPost() {
    Get.toNamed(BaseRouters.testApi);
  }

  void toNotificationPage() {
    Get.toNamed(BaseRouters.testNotification);
  }

  void toShortVideoPage() {
    Get.toNamed(BaseRouters.shortVideo);
  }

  void toShortVideoPreloadPage() {
    Get.toNamed(BaseRouters.shortVideoPreload);
  }

  void toShortVideoCache() {
    Get.toNamed(BaseRouters.shortVideoCache);
  }

  void toShort() {
    Get.toNamed(BaseRouters.testShort);
  }
}
