import 'package:flutter_base_project/core/services/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/data_source/isar_service.dart';
import 'package:flutter_base_project/data/data_source/local_file_service.dart';
import 'package:flutter_base_project/data/interceptor/logging_interceptor.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:flutter_base_project/data/repo/local_file_repo.dart';
import 'package:flutter_base_project/data/repo/remote/auth_repo.dart';
import 'package:flutter_base_project/data/repo/remote/exports.dart';
import 'package:get_it/get_it.dart';

import '../services/notification_service/local_notification_service.dart';

final appGlobal = GetIt.instance;

mixin DiContainer {
  static Future<void> init() async {
    appGlobal.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    await Future.wait([initIsar(), initDio(), initLocalFile()]);

    // Audio service
    appGlobal.registerLazySingleton<AudioService>(() => AudioService());

    // Notification service
    appGlobal.registerSingleton<LocalNotificationService>(
        LocalNotificationService()..init());
  }

  static Future<void> initIsar() async {
    await IsarService.I.init();
    appGlobal.registerLazySingleton<ProductLocalRepo>(() => ProductLocalRepo());
  }

  static Future<void> initDio() async {
    DioClient.I.init();
    appGlobal.registerLazySingleton<PostRepo>(() => PostRepo());
    appGlobal.registerLazySingleton<FilmRepo>(() => FilmRepo());
    appGlobal.registerLazySingleton<AuthRepo>(() => AuthRepo());
  }

  static Future<void> initLocalFile() async {
    LocalFileService.I.init();
    appGlobal.registerLazySingleton<LocalFileRepo>(() => LocalFileRepo());
  }
}
