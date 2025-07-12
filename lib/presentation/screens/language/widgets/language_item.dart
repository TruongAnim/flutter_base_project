import 'package:flutter/material.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/exports.dart';
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
          AppUtil.addVibration(callback: () {
            controller.onLanguageChange(index);
          });
        },
        child: Container(
          width: SizeUtil.screenWidth,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.WHITE : AppColors.BACK_GROUND,
            borderRadius: BorderRadius.circular(10),
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
              spaceWidth(15),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ImageWidget(
                  lang.imagePath,
                  height: 40,
                  width: 40,
                ),
              ),
              spaceWidth(15),
              Text(
                lang.title,
                style:
                    const TextStyle(fontSize: 16, color: AppColors.Neutral_8),
              ),
              const Spacer(),
              CircleCheckbox(isCheck: isSelected, size: 24),
              spaceWidth(15),
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
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.Neutral_78, width: 2),
            ),
          );
  }
}
