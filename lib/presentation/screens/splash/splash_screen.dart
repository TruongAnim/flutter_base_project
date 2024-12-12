import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/presentation/base_widgets/image_widget.dart';
import 'package:flutter/material.dart';
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
            animation: controller.progressController,
            builder: (context, child) {
              return Transform.scale(
                scale: 0.1 + controller.progressValue.value * 0.9,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageWidget(
                      AppImages.logo,
                      width: 100,
                    )
                  ],
                ),
              );
            },
          ),
        ),
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
