import 'package:flutter/material.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/exports.dart';
import 'package:flutter_base_project/presentation/custom_widgets/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'language_controller.dart';
import 'widgets/language_item.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !controller.isIntro.value,
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND,
        extendBody: true,
        body: Column(
          children: [
            CustomAppbar(title: 'choose_language'.tr),
            // spaceHeight(10.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount: controller.languages.length,
                separatorBuilder: (_, __) {
                  return Gap(10.h);
                },
                itemBuilder: (context, index) {
                  return LanguageItem(index: index);
                },
              ),
            ),
          ],
        ).marginOnly(bottom: 48.h),
        bottomNavigationBar: Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: RoundButton(
                isActive: controller.isIntro.value == true ||
                    controller.oldSelectedIndex != controller.selectedIndex,
                height: 44.h,
                title: controller.isIntro.value == true ? 'next'.tr : "save".tr,
                callback: controller.onSelectLanguageChange,
              ),
            )),
      ),
    );
  }
}
