import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'test_nofitication_controller.dart';

class TestNotificationScreen extends GetView<TestNotificationController> {
  const TestNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: SizedBox(
        height: sh,
        child: Column(
          children: [
            const MaxGap(40),
            ListTile(
              onTap: controller.requestPermission,
              title: const Text('Request permission'),
              tileColor: Colors.blue,
              textColor: Colors.white,
            ),
            Gap(12),
            ListTile(
              onTap: controller.showNoti,
              title: const Text('Show noti'),
              tileColor: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
