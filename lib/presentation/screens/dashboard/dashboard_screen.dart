import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: controller.listProducts.length,
          itemBuilder: (context, index) {
            return Text(controller.listProducts[index].name.toString());
          },
        );
      }),
    );
  }
}
