import 'dart:collection';
import 'package:flutter_base_project/core/global/di_container.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/shared_preference/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'language/exports.dart';

class LocalizationService extends Translations {
// Get locale.
  static final locale = _getLocaleFromLanguage();

// Locale default.
  static const fallbackLocale = Locale('en', 'EN');

  static final langCodes = [
    'en',
    'vi',
  ];

  // Locale have support.
  static final locales = [
    const Locale('en', 'EN'),
    const Locale('vi', 'VI'),
  ];

// Language data to change.
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Việt Nam',
  });

  // Multi Language data to change.
  final homeMultiLangs = LinkedHashMap.from({
    'en': 'english'.tr,
    'vi': 'vietnamese'.tr,
  });

  ///
  /// On change language.
  ///
  static void changeLocale(String langCode) {
    // Save locale.
    appGlobal<SharedPrefsHelper>().setLocale(langCode);
    final locale = _getLocaleFromLanguage(langCode: langCode);
    DefaultCupertinoLocalizations.load(locale);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    late String lang;
    if (nullOrEmpty(langCode) && !nullOrEmpty(appLocal)) {
      lang = appLocal.toString();
    } else if (!nullOrEmpty(langCode)) {
      lang = langCode.toString();
    } else {
      lang = Get.deviceLocale!.languageCode;

      // Save locale.
      appGlobal<SharedPrefsHelper>().setLocale(lang);
    }
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) {
        CommonHelper.local = lang;
        return locales[i];
      }
    }
    // DefaultCupertinoLocalizations.load(locale);
    return Get.locale ?? fallbackLocale;
  }
}
