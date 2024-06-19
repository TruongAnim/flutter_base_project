import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      bottomNavigationBar: Container(
        width: 1.sw,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: controller.toHighlightPage,
                child:
                    Text('To hgihlight page', style: Get.textTheme.bodyMedium!),
              ),
              ElevatedButton(
                onPressed: controller.toNotificationPage,
                child: Text('To notification page',
                    style: Get.textTheme.bodyMedium!),
              ),
              ElevatedButton(
                onPressed: controller.toListPost,
                child: Text(
                  'To list post',
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.green : Colors.pink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
