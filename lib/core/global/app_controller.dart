import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:get/get.dart';

class AppController extends GetxController with WidgetsBindingObserver {
  static const String tag = 'AppController';
  Rx<AppLifecycleState> appLifecycleState =
      Rx<AppLifecycleState>(AppLifecycleState.resumed);

  @override
  void onInit() async {
    super.onInit();
    appLog(tag: tag, msg: 'onInit');
    WidgetsBinding.instance.addObserver(this);
    _setup();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _setup() async {
    bool isFirstTimeOpen = SharedPref.instance.getIsFirstOpen;
    if (isFirstTimeOpen) {
      await _initData();
    }
  }

  Future<void> _initData() async {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState.value = state;
  }
}
