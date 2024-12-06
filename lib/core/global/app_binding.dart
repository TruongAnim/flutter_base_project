import 'package:get/get.dart';
import 'app_controller.dart';
import 'auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
    Get.put<AuthController>(AuthController());
  }
}
