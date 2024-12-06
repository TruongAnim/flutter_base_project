import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/routes/exports.dart';
import 'package:flutter_base_project/core/global/auth_controller.dart';
import 'package:flutter_base_project/core/shared_preference/shared_pref.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController progressController;
  late final Animation<double> progressValue;
  final double _startValue = 0.2;

  @override
  void onInit() {
    super.onInit();
    progressController = AnimationController(
      vsync: this,
      value: _startValue,
    );
    progressController.addStatusListener(_onStatusListener);
    progressValue = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: progressController,
        curve: Curves.easeIn,
      ),
    );

    _login();
  }

  @override
  void onClose() {
    progressController.dispose();
    super.onClose();
  }

  void _onStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Get.toNamed(BaseRouters.dashboard);
    }
  }

  Future<void> _login() async {
    // Load data sync
    final loginDone = await Get.find<AuthController>().login();
    if (!loginDone) {
      Get.toNamed(BaseRouters.noNetwork);
      return;
    }
    _loadData();
  }

  Future<void> _loadData() async {
    // Load data async
    progressController.duration =
        Duration(milliseconds: SharedPref.I.getIsFirstOpen ? 2500 : 1500);
    progressController.forward(from: _startValue);
  }
}
