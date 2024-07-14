import 'package:flutter_base_project/config/routes/exports.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/services/exports.dart';
import 'package:get/get.dart';

import 'view_models/language_view_model.dart';

class LanguageController extends GetxController {
  static const String tag = 'LanguageController';
  static const String argIsIntro = 'argIsIntro';
  final RxInt selectedIndex = 0.obs;
  final RxInt oldSelectedIndex = 0.obs;
  RxBool isIntro = false.obs;

  final List<LanguageViewModel> languages = [
    LanguageViewModel(
        title: 'english'.tr, imagePath: AppImages.enFlag, value: 'en'),
    LanguageViewModel(
        title: 'vietnamese'.tr, imagePath: AppImages.jpFlag, value: 'vi'),
  ];

  @override
  void onInit() {
    final val = Get.arguments;
    if (val is Map<String, dynamic> && val[argIsIntro] != null) {
      isIntro.value = val[argIsIntro];
    }
    getCurrentLanguage();
    super.onInit();
  }

  ///
  /// Get language default.
  ///
  void getCurrentLanguage() {
    appLog(tag: tag, msg: appLocal);
    selectedIndex.value =
        languages.indexWhere((item) => item.value == appLocal);

    oldSelectedIndex.value = selectedIndex.value;
  }

  ///
  /// On change Language.
  ///
  void onLanguageChange(int val) {
    selectedIndex.value = val;
  }

  ///
  /// On select language.
  ///
  void onSelectLanguageChange() {
    final newLocal = languages[selectedIndex.value].value;
    // Change language.
    LocalizationService.changeLocale(newLocal);

    if (isIntro.value) {
      Get.offAllNamed(BaseRouters.dashboard);
    } else {
      Get.back();
    }
  }
}
