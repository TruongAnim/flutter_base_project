import 'package:flutter_base_project/constants/app_constants.dart';
import 'package:flutter_base_project/core/helper/device_util.dart';

enum AdsType {
  banner,
  reward,
  rewardInter,
  inter,
  open,
  native,
}

enum AdsMode {
  test,
  product,
}

enum AdsPlatform {
  android,
  ios,
}

class AdmobManager {
  static final AdmobManager _instance = AdmobManager._internal();
  AdmobManager._internal();
  static get instance => _instance;
  factory AdmobManager() {
    return _instance;
  }

  static final testAndroid = AdsMode.test.name + AdsPlatform.android.name;
  static final testIos = AdsMode.test.name + AdsPlatform.ios.name;
  static final productAndroid = AdsMode.product.name + AdsPlatform.android.name;
  static final productIos = AdsMode.product.name + AdsPlatform.ios.name;

  Map<String, String> adsId = {
    // Test mode
    // ---------- Android ----------
    testAndroid + AdsType.banner.name: 'ca-app-pub-3940256099942544/6300978111',
    testAndroid + AdsType.reward.name: 'ca-app-pub-3940256099942544/5224354917',
    testAndroid + AdsType.rewardInter.name:
        '	ca-app-pub-3940256099942544/5354046379',
    testAndroid + AdsType.inter.name: 'ca-app-pub-3940256099942544/1033173712',
    testAndroid + AdsType.open.name: 'ca-app-pub-3940256099942544/9257395921',
    testAndroid + AdsType.native.name: 'ca-app-pub-3940256099942544/2247696110',
    // --------- IOS ------------------
    testIos + AdsType.banner.name: 'ca-app-pub-3940256099942544/2934735716',
    testIos + AdsType.reward.name: 'ca-app-pub-3940256099942544/1712485313',
    testIos + AdsType.rewardInter.name:
        'ca-app-pub-3940256099942544/6978759866',
    testIos + AdsType.inter.name: 'ca-app-pub-3940256099942544/4411468910',
    testIos + AdsType.open.name: 'ca-app-pub-3940256099942544/5575463023',
    testIos + AdsType.native.name: 'ca-app-pub-3940256099942544/3986624511',

    // Product mode
    // ---------- Android ----------
    productAndroid + AdsType.banner.name: '',
    productAndroid + AdsType.reward.name: '',
    productAndroid + AdsType.rewardInter.name: '',
    productAndroid + AdsType.inter.name: '',
    productAndroid + AdsType.open.name: '',
    productAndroid + AdsType.native.name: '',
    // --------- IOS ------------------
    productIos + AdsType.banner.name: '',
    productIos + AdsType.reward.name: '',
    productIos + AdsType.rewardInter.name: '',
    productIos + AdsType.inter.name: '',
    productIos + AdsType.open.name: '',
    productIos + AdsType.native.name: '',
  };

  String getAdsId(AdsType type) {
    String mode = AppConsts.isPoduct ? AdsMode.product.name : AdsMode.test.name;
    String platform =
        DeviceUtil.isAndroid ? AdsPlatform.android.name : AdsPlatform.ios.name;
    String key = mode + platform + type.name;
    return adsId[key]!;
  }
}
