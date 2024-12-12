import 'package:flutter_base_project/presentation/screens/home/home_binding.dart';
import 'package:flutter_base_project/presentation/screens/home/home_screen.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_binding.dart';
import 'package:flutter_base_project/presentation/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

mixin BaseRouters {
  static const String splash = '/splash';
  static const String language = '/language';
  static const String noNetwork = '/no-network';
  static const String intro = '/intro';
  static const String home = '/home';

  static List<GetPage> listPage = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: language,
    //   page: () => const LanguageScreen(),
    //   binding: LanguageBinding(),
    // ),
    // GetPage(
    //   name: noNetwork,
    //   page: () => const NoNetworkScreen(),
    //   binding: NoNetworkBinding(),
    // ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
