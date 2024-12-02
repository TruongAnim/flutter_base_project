import 'package:flutter_base_project/config/routes/base_routers.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final ProductLocalRepo productRepo = appGlobal<ProductLocalRepo>();
  RxList<ProductLocalModel> listProducts = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
    SharedPref.instance.setJwtToken(
        'ODg5MA.4TgyyGu55cnp0BY04YE9SUi7nvhzeeuFrnbHEmOpUrTOll8ybgzC2OX5ZhVb');
  }

  Future<void> initData() async {
    await productRepo.getAll(
      onSuccess: (result) {
        listProducts.value = result;
        isLoading.value = false;
      },
      onError: (err) {},
    );
  }

  void toListPost() {
    Get.toNamed(BaseRouters.listPost);
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
