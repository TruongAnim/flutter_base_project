import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/routes/base_routers.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:flutter_base_project/presentation/screens/test_highlight_text.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final ProductLocalRepo productRepo = appGlobal<ProductLocalRepo>();
  RxList<ProductLocalModel> listProducts = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
    appGlobal<SharedPreferenceHelper>().setJwtToken(
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

  void toHighlightPage() {
    print('hello');
    Navigator.of(Get.context!)
        .push(MaterialPageRoute(builder: (context) => TestHighlightText()));
  }

  void toShortVideoPage() {
    Get.toNamed(BaseRouters.shortVideo);
  }

  void toShortVideoPreloadPage() {
    Get.toNamed(BaseRouters.shortVideoPreload);
  }
}
