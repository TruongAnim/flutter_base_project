import 'package:flutter_base_project/data/interceptor/logging_interceptor.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:flutter_base_project/data/repo/local_file_repo.dart';
import 'package:flutter_base_project/data/repo/remote/post_repo.dart';
import 'package:flutter_base_project/data/repo/remote/remote_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preference/shared_preference_helper.dart';

final appGlobal = GetIt.instance;

mixin DiContainer {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    // Share preference
    sharedPreferences = await SharedPreferences.getInstance();
    appGlobal.registerLazySingleton<SharedPreferenceHelper>(
        () => SharedPreferenceHelper());

    appGlobal.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    LocalRepo localRepo = LocalRepo();
    await localRepo.init();
    RemoteRepo remoteRepo = RemoteRepo()..init();
    LocalFileRepo localFileRepo = LocalFileRepo()..init();

    // Local File
    appGlobal.registerLazySingleton<LocalFileRepo>(() => localFileRepo);

    // Local DB
    appGlobal.registerSingleton<LocalRepo>(localRepo);
    appGlobal.registerSingleton<ProductLocalRepo>(ProductLocalRepo(localRepo));

    // Remote DB
    appGlobal.registerSingleton<RemoteRepo>(remoteRepo);
    appGlobal.registerSingleton<PostRepo>(PostRepo(remoteRepo));

    // // Audio service
    // appGlobal.registerLazySingleton<AudioService>(() => AudioService());
  }
}
