import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: PopScope(
        canPop: false,
        child: Center(
          child: AnimatedBuilder(
            animation: controller.bounceAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 0.1 + controller.bounceAnimation.value * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.2.sh * 0.2),
                      child: ImageWidget(AppImages.logoApp, height: 0.2.sh),
                    ).marginOnly(bottom: 32.h),
                    ImageWidget(AppImages.appName)
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.2.sw, vertical: 0.1.sh),
        child: const LinearProgressIndicator(
          backgroundColor: AppColors.WIDGET_BG,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.PRIMARY_1),
        ),
      ),
    );
  }
}
