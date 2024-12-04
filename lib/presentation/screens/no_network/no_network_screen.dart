import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'no_network_controller.dart';

class NoNetworkScreen extends GetView<NoNetworkController> {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: PopScope(
        canPop: false,
        child: Center(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.2, vertical: 0.1),
        child: const LinearProgressIndicator(
          backgroundColor: AppColors.WIDGET_BG,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.PRIMARY_1),
        ),
      ),
    );
  }
}
