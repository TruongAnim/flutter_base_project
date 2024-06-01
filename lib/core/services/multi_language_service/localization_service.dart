import 'dart:collection';
import 'package:flutter_base_project/core/global/di_container.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/helper/validate_helper.dart';
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
    'de',
    'en',
    'es',
    'fr',
    'lt',
    'nl',
    'pl',
    'ru',
    'sv',
    'ja',
    'it',
    'uk',
  ];

  // Locale have support.
  static final locales = [
    const Locale('de', 'DE'),
    const Locale('en', 'EN'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
    const Locale('lt', 'LT'),
    const Locale('nl', 'NL'),
    const Locale('pl', 'PL'),
    const Locale('ru', 'RU'),
    const Locale('sv', 'SV'),
    const Locale('ja', 'JA'),
    const Locale('it', 'IT'),
    const Locale('uk', 'UK'),
  ];

// Language data to change.
  static final langs = LinkedHashMap.from({
    'de': 'Đức',
    'en': 'English',
    'es': 'Tây Ban Nha',
    'fr': 'Pháp',
    'lt': 'Litva',
    'nl': 'Hà Lan',
    'pl': 'Ba Lan',
    'ru': 'Nga',
    'sv': 'Thụy Điển',
    'ja': 'Nhật Bản',
    'it': 'Italia',
    'uk': 'Ukraina',
  });

  // Multi Language data to change.
  final homeMultiLangs = LinkedHashMap.from({
    'en': 'English'.tr,
    'de': 'German'.tr,
    'es': 'Spanish'.tr,
    'fr': 'French'.tr,
    'lt': 'Lithuanian'.tr,
    'nl': 'Dutch'.tr,
    'pl': 'Polish'.tr,
    'ru': 'Russian'.tr,
    'sv': 'Swedish'.tr,
    'ja': 'Japanese'.tr,
    'it': 'Italian'.tr,
    'uk': 'Ukrainian'.tr,
  });

  ///
  /// On change language.
  ///
  static void changeLocale(String langCode) {
    // Save locale.
    appGlobal<SharedPreferenceHelper>().setLocale(langCode);
    final locale = _getLocaleFromLanguage(langCode: langCode);
    DefaultCupertinoLocalizations.load(locale);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'de_GE': de,
        'es_ES': es,
        'fr_FR': fr,
        'lt_LI': lt,
        'nl_NE': nl,
        'pl_PO': pl,
        'ru_RU': ru,
        'sv_SW': sv,
        'ja_JP': ja,
        'it_IT': it,
        'uk_UK': uk,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    late String lang;
    if (nullOrEmpty(langCode) &&
        !nullOrEmpty(appGlobal<SharedPreferenceHelper>().getLocale)) {
      lang = appGlobal<SharedPreferenceHelper>().getLocale.toString();
    } else if (!nullOrEmpty(langCode)) {
      lang = langCode.toString();
    } else {
      lang = Get.deviceLocale!.languageCode;

      // Save locale.
      appGlobal<SharedPreferenceHelper>().setLocale(lang);
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
