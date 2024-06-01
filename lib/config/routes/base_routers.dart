// import 'package:base_project/presentation/screens/go_premium/go_premium_binding.dart';
// import 'package:base_project/presentation/screens/go_premium/go_premium_screen.dart';
// import 'package:base_project/presentation/screens/intro/intro_binding.dart';
// import 'package:base_project/presentation/screens/intro/intro_screen.dart';
// import 'package:base_project/presentation/screens/language/language_binding.dart';
// import 'package:base_project/presentation/screens/language/language_screen.dart';
// import 'package:base_project/presentation/screens/main_navigator/main_navigator_screen.dart';
// import 'package:base_project/presentation/screens/select_date/select_date_binding.dart';
// import 'package:base_project/presentation/screens/select_date/select_date_screen.dart';
// import 'package:base_project/presentation/screens/splash/splash_binding.dart';
// import 'package:base_project/presentation/screens/splash/splash_screen.dart';
// import 'package:base_project/presentation/screens/survey/survey_binding.dart';
// import 'package:base_project/presentation/screens/survey/survey_screen.dart';
// import 'package:base_project/presentation/screens/well_come/well_come_screen.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_binding.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

mixin BaseRouters {
  static const String SPLASH = '/splash';
  static const String LANGUAGE = '/language';
  static const String INTRO = '/intro';
  static const String MAIN_NAVIGATOR = '/main_navigator';

  static List<GetPage> listPage = [
    GetPage(
      name: SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: LANGUAGE,
    //   page: () => const LanguageScreen(),
    //   binding: LanguageBinding(),
    // ),
    // GetPage(
    //   name: INTRO,
    //   page: () => const IntroScreen(),
    //   binding: IntroBinding(),
    // ),
    // GetPage(
    //   name: MAIN_NAVIGATOR,
    //   page: () => const MainNavigatorScreen(),
    //   binding: BottomTabBinding(),
    // ),
  ];
}
