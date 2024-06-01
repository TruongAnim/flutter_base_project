import 'dart:async';
// import 'package:base_project/core/app_connect_network/app_connect_network.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:get/get.dart';

import 'di_container.dart';
import 'init_data_helper.dart';

class AppController extends GetxController {
  // final _isarRepo = appGlobal<IsarRepo>();
  // final AppConnectService _appConnectService = AppConnectService();

  @override
  void onInit() async {
    super.onInit();
    // _appConnectService.onInit();
    _setup();
  }

  void _setup() async {
    bool isFirstTimeOpen = appGlobal<SharedPreferenceHelper>().getIsFirstOpen;
    if (isFirstTimeOpen) {
      appPrint('Init Data: ${DateTime.now()}');
      await _initData();
      appPrint('Init done: ${DateTime.now()}');
    }
  }

  Future<void> _initData() async {
    // final dataHepler = InitDataHelper();
    // await dataHepler.initData();
  }
}
