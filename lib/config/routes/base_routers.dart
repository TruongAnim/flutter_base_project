import 'package:flutter_base_project/presentation/screens/dashboard/dashboard_binding.dart';
import 'package:flutter_base_project/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_base_project/presentation/screens/language/language_binding.dart';
import 'package:flutter_base_project/presentation/screens/language/language_screen.dart';
import 'package:flutter_base_project/presentation/screens/list_post/list_post_binding.dart';
import 'package:flutter_base_project/presentation/screens/list_post/list_post_screen.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_binding.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

mixin BaseRouters {
  static const String splash = '/splash';
  static const String language = '/language';
  static const String INTRO = '/intro';
  static const String dashboard = '/dashboard';
  static const String listPost = '/list-post';

  static List<GetPage> listPage = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
    // GetPage(
    //   name: INTRO,
    //   page: () => const IntroScreen(),
    //   binding: IntroBinding(),
    // ),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: listPost,
      page: () => const ListPostScreen(),
      binding: ListPostBinding(),
    ),
  ];
}
