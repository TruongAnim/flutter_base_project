import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get/get.dart';

class TestApiController extends GetxController {
  static const String tag = 'TestApiController';
  final PostRepo postRepo = appGlobal<PostRepo>();
  RxList<PostModel> listPost = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    final apiResponse = await postRepo.paginate();
    isLoading.value = false;
    if (apiResponse.r != null) {
      appLog(tag: tag, msg: "load data done");
      listPost.value = apiResponse.r!;
    } else {
      appLog(tag: tag, msg: apiResponse.e);
      listPost.value = [];
    }
  }
}
