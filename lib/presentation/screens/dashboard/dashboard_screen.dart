import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
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
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: controller.listProducts.length,
          itemBuilder: (context, index) {
            return Text(controller.listProducts[index].name.toString());
          },
        );
      }),
      bottomNavigationBar: SizedBox(
        width: SizeUtil.screenWidth,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: controller.toShortVideoPage,
                child: Text('To short video page',
                    style: Get.textTheme.bodyMedium!),
              ),
              ElevatedButton(
                onPressed: controller.toShortVideoPreloadPage,
                child: Text('To short video preload page',
                    style: Get.textTheme.bodyMedium!),
              ),
              ElevatedButton(
                onPressed: controller.toShortVideoCache,
                child: Text('To short video cache page',
                    style: Get.textTheme.bodyMedium!),
              ),
              ElevatedButton(
                onPressed: controller.toShort,
                child: Text('To short test', style: Get.textTheme.bodyMedium!),
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
