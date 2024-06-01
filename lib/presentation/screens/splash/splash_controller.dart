import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/routes/exports.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> bounceAnimation;
  // final premiumCtrl = Get.find<PremiumController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    showAnimationLogo();
    _startApp();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _startApp() async {
    _loadingAds(callback: toSecondScreen);
  }

  void showAnimationLogo() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    bounceAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    );

    animationController.forward();
  }

  void toSecondScreen() {
    bool isFirstOpen = appGlobal<SharedPreferenceHelper>().getIsFirstOpen;
    if (isFirstOpen) {
      Get.offAllNamed(BaseRouters.LANGUAGE, arguments: {'isIntro': true});
    } else {
      // premiumCtrl.handleActionWithPremiumRole(() {
      //   Get.offAllNamed(BaseRouters.MAIN_NAVIGATOR);
      // }, true);
    }
  }

  void _loadingAds({required void Function() callback}) {
    // Fake loading
    Future.delayed(const Duration(seconds: 3), callback);
  }
}
