import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'test_api_controller.dart';

class TestApiScreen extends GetView<TestApiController> {
  const TestApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return CircularProgressIndicator();
        }
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.listPost.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Colors.blue,
              textColor: Colors.white,
              title: Text(controller.listPost[index].title.toString()),
            );
          },
        );
      }),
    );
  }
}
