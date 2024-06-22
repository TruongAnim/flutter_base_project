import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/video_player_widget.dart';
import 'short_video_controller.dart';

class ShortVideoScreen extends GetView<ShortVideoController> {
  const ShortVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return CircularProgressIndicator();
        }
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.listFilm.length,
          itemBuilder: (context, index) {
            return VideoPlayerWidget(
                url: controller.listFilm[index].episode?.link ?? '');
          },
        );
      }),
    );
  }
}
