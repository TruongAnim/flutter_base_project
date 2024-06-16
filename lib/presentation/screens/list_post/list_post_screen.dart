import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_post_controller.dart';

class ListPostScreen extends GetView<ListPostController> {
  const ListPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: controller.listPost.length,
          itemBuilder: (context, index) {
            return Text(controller.listPost[index].user.toString());
          },
        );
      }),
    );
  }
}
