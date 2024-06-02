import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'config/routes/exports.dart';
import 'config/theme/exports.dart';
import 'constants/exports.dart';
import 'core/global/exports.dart';
import 'core/services/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init firebase.
  await Firebase.initializeApp(
      name: "Flutter base project",
      options: DefaultFirebaseOptions.currentPlatform);
  await CrashlyticsService.init();

  // Set local.
  time_ago.setLocaleMessages('vi', time_ago.ViMessages());

  // Init Get it.
  await DiContainer.init();
  await FirebaseAppCheck.instance.activate();
  await NotificationService.init();

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, index) {
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
            localizationsDelegates: AppConstants.localizationsDelegates,
            supportedLocales: LocalizationService.locales,
            builder: EasyLoading.init(
              builder: (context, widget) {
                return Theme(
                  data: lightTheme,
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        boldText: false, textScaler: TextScaler.noScaling),
                    child: widget!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
