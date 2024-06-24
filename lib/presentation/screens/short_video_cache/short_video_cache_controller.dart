import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/models/film_model.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get/get.dart';

import 'cache_video_service.dart';

class ShortVideoCacheController extends GetxController {
  final FilmRepo remoteRepo = appGlobal<FilmRepo>();
  final LoadVideoService loadVideo = appGlobal<LoadVideoService>();
  RxList<FilmModel> listFilm = RxList();
  RxBool isLoading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await remoteRepo.getAllShort(
      filter: '&language=us',
      onSuccess: (result) {
        appPrint("load data done");
        listFilm.value = result;
        isLoading.value = false;
      },
      onError: (err) {
        appPrint(err);
      },
    );
    for (final item in listFilm.take(5)) {
      loadVideo.loadVideo(item.episode?.link ?? '');
    }
  }
}
