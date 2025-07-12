import 'package:get/get.dart';

mixin RouteUtil {
  static bool containRoute(String routeName) {
    for (var route in Get.routeTree.routes) {
      if (route.name == routeName) {
        return true;
      }
    }
    return false;
  }

  static void backToRoute(String routeName) {
    if (containRoute(routeName)) {
      Get.until((route) => Get.currentRoute == routeName);
    } else {
      Get.back();
    }
  }
}
