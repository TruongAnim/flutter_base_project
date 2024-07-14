import 'package:flutter_base_project/core/helper/device_util.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/services/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/interceptor/logging_interceptor.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:flutter_base_project/data/repo/local_file_repo.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service/local_notification_service.dart';
import '../shared_preference/shared_preference_helper.dart';

final appGlobal = GetIt.instance;

mixin DiContainer {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    DeviceUtil.initialize();
    // Local notification
    LocalNotificationService localNotificationService =
        LocalNotificationService();
    await localNotificationService.init();
    // Firebase Crashlytics
    appGlobal
        .registerSingleton<CrashlyticsService>(CrashlyticsService()..init());

    // Share preference
    sharedPreferences = await SharedPreferences.getInstance();
    appGlobal
        .registerLazySingleton<SharedPrefsHelper>(() => SharedPrefsHelper());

    appGlobal.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    LocalRepo localRepo = LocalRepo();
    await localRepo.init();
    DioClient dio = DioClient();
    RemoteRepo remoteRepo = RemoteRepo(dio);
    LocalFileRepo localFileRepo = LocalFileRepo()..init();

    // Local File
    appGlobal.registerLazySingleton<LocalFileRepo>(() => localFileRepo);

    // Local DB
    appGlobal.registerSingleton<LocalRepo>(localRepo);
    appGlobal.registerSingleton<ProductLocalRepo>(ProductLocalRepo(localRepo));

    // Remote DB
    appGlobal.registerSingleton<DioClient>(dio);
    appGlobal.registerSingleton<RemoteRepo>(remoteRepo);
    appGlobal.registerSingleton<PostRepo>(PostRepo(remoteRepo));
    appGlobal.registerSingleton<FilmRepo>(FilmRepo(remoteRepo));

    // Audio service
    appGlobal.registerLazySingleton<AudioService>(() => AudioService());

    // Notification service
    appGlobal
        .registerSingleton<LocalNotificationService>(localNotificationService);
  }
}
