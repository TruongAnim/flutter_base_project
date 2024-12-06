import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND,
      body: SizedBox(
        height: SizeUtil.screenHeight,
        width: SizeUtil.screenWidth,
        child: ListView.separated(
            separatorBuilder: (context, index) => spaceHeight(10),
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.blue,
                textColor: Colors.white,
                title: Text(controller.listFunction[index].item1),
                onTap: () {
                  controller.listFunction[index].item2();
                },
              );
            },
            itemCount: controller.listFunction.length),
      ),
    );
  }
}
