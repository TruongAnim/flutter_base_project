import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'short_video_cache_controller.dart';
import 'video_list_stateful.dart';

class ShortVideoCacheScreen extends GetView<ShortVideoCacheController> {
  const ShortVideoCacheScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return CircularProgressIndicator();
        }
        return VideoPageView();
      }),
    );
  }
}
