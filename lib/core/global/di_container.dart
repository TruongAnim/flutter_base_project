import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preference/shared_preference_helper.dart';

final appGlobal = GetIt.instance;

mixin DiContainer {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    // Local DB
    // appGlobal.registerSingleton<IsarRepo>(IsarRepo()..init());
    // appGlobal.registerLazySingleton<DioRepo>(() => DioRepo()..init());

    // Share preference
    sharedPreferences = await SharedPreferences.getInstance();
    appGlobal.registerLazySingleton<SharedPreferenceHelper>(
        () => SharedPreferenceHelper());

    // // Audio service
    // appGlobal.registerLazySingleton<AudioService>(() => AudioService());
  }
}
