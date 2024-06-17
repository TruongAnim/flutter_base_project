import 'package:flutter/material.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../language_controller.dart';
import '../view_models/language_view_model.dart';

class LanguageItem extends GetView<LanguageController> {
  const LanguageItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final LanguageViewModel lang = controller.languages[index];
      final bool isSelected = controller.selectedIndex.value == index;
      return GestureDetector(
        onTap: () {
          CommonHelper.addVibration(callback: () {
            controller.onLanguageChange(index);
          });
        },
        child: Container(
          width: 1.sw,
          height: 64.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.WHITE : AppColors.BACK_GROUND,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              spaceWidth(15.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.h),
                child: ImageWidget(
                  lang.imagePath,
                  height: 40.h,
                  width: 40.h,
                ),
              ),
              spaceWidth(15.w),
              Text(
                lang.title,
                style: TextStyle(fontSize: 16.sp, color: AppColors.Neutral_8),
              ),
              const Spacer(),
              CircleCheckbox(isCheck: isSelected, size: 24.w),
              spaceWidth(15.w),
            ],
          ),
        ),
      );
    });
  }
}

class CircleCheckbox extends StatelessWidget {
  const CircleCheckbox(
      {super.key, required this.isCheck, required this.size, this.iconPath});
  final bool isCheck;
  final double size;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return isCheck
        ? ImageWidget(
            iconPath ?? AppImages.icCheck,
            width: size,
            height: size,
          )
        : Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              border: Border.all(color: AppColors.Neutral_78, width: 2),
            ),
          );
  }
}
