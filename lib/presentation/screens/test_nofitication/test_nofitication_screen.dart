import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'test_nofitication_controller.dart';

class TestNotificationScreen extends GetView<TestNotificationController> {
  const TestNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Container(
        height: 1.sh,
        child: Column(
          children: [
            MaxGap(40.h),
            ElevatedButton(
              onPressed: controller.requestPermission,
              child: Text('Request permission'),
            ),
            ElevatedButton(
              onPressed: controller.showNoti,
              child: Text('Show noti'),
            ),
          ],
        ),
      ),
    );
  }
}
