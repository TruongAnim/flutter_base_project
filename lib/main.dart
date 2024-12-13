import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/core/shared_preference/shared_pref.dart';
import 'package:flutter_base_project/firebase_options.dart';
import 'package:flutter_base_project/core/services/multi_language_service/localization_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'config/routes/exports.dart';
import 'config/theme/exports.dart';
import 'constants/exports.dart';
import 'core/global/exports.dart';
import 'core/helper/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init firebase.
  await Firebase.initializeApp(
      name: "Flutter base project",
      options: DefaultFirebaseOptions.currentPlatform);

  await _initApp();

  /// Instance Easy Loading.
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..progressColor = AppColors.WHITE
    ..backgroundColor = AppColors.PRIMARY_1
    ..indicatorColor = AppColors.WHITE
    ..textColor = AppColors.WHITE
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      // color: ColorResources.WHITE,
    )
    ..dismissOnTap = false;

  // Set Device Orientation.
  _updateSystemChrome();

  // Run app.
  runApp(const MyApp());
}

void _updateSystemChrome() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

Future<void> _initApp() async {
  await SharedPref.instance.init();
  await AppTrackingTransparency.requestTrackingAuthorization();
  // Init Get it.
  await DiContainer.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeUtil.initialize(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        initialRoute: BaseRouters.splash,
        initialBinding: AppBinding(),
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        defaultTransition: Transition.leftToRight,
        transitionDuration: const Duration(),
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        localizationsDelegates: AppConst.localizationsDelegates,
        supportedLocales: LocalizationService.locales,
        builder: EasyLoading.init(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(boldText: false, textScaler: TextScaler.noScaling),
              child: widget!,
            );
          },
        ),
      ),
    );
  }
}
