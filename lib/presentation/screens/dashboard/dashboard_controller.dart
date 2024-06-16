import 'package:flutter_base_project/config/routes/base_routers.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final ProductLocalRepo productRepo = appGlobal<ProductLocalRepo>();
  RxList<ProductLocalModel> listProducts = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await productRepo.getAll(
      onSuccess: (result) {
        listProducts.value = result;
        isLoading.value = false;
      },
      onError: (err) {},
    );
  }

  void toListPost() {
    Get.toNamed(BaseRouters.listPost);
  }
}
