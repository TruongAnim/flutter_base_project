import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get/get.dart';

class ListPostController extends GetxController {
  final RemoteRepo remoteRepo = appGlobal<RemoteRepo>();
  RxList<PostModel> listPost = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await remoteRepo.paginate<PostModel>(
      filter: '&populate=userId',
      onSuccess: (result) {
        appPrint("load data done");
        listPost.value = result;
        isLoading.value = false;
      },
      onError: (err) {
        appPrint(err);
      },
    );
  }
}
