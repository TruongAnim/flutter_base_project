import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get/get.dart';

class ListPostController extends GetxController {
  static const String tag = 'ListPostController';
  final PostRepo postRepo = appGlobal<PostRepo>();
  RxList<PostModel> listPost = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    final apiResponse = await postRepo.paginate(filter: '&populate=userId');
    if (apiResponse.r != null) {
      appLog(tag: tag, msg: "load data done");
      listPost.value = apiResponse.r!;
      isLoading.value = false;
    } else {
      appLog(tag: tag, msg: apiResponse.e);
    }
  }
}
