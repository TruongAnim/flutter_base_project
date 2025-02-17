import 'dart:async';
import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admob_manager/admob_manager.dart';
import '../admob_manager/ads_controller.dart';

class RewardAdsService extends AdsController {
  static final RewardAdsService _instance = RewardAdsService._internal();
  RewardAdsService._internal();

  factory RewardAdsService() {
    return _instance;
  }

  static get instance => _instance;

  @override
  void init() {
    adsId = AdmobManager.instance.getAdsId(AdsType.reward);
  }

  @override
  Future<AdsState> loadAds(String place) async {
    if (adsState == AdsState.loading || adsState == AdsState.ready) {
      return adsState;
    }
    updateState = AdsState.loading;
    // trackEvent(AdsEvent.eventNameAdsLoad, place);
    await RewardedAd.load(
      adUnitId: adsId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          // trackEvent(AdsEvent.eventNameAdsLoadSuccess, place);
          ads = ad;
          updateState = AdsState.ready;
          retryLoad = 2;
        },
        onAdFailedToLoad: (err) {
          log('Failed to load a rewarded ad: ${err.message}');
          // trackEvent(AdsEvent.eventNameAdsLoadFail, place);
          updateState = AdsState.error;
        },
      ),
    );
    return adsState;
  }

  @override
  void showAds({
    required String place,
    Function? onSuccess,
    Function? onShow,
    Function? onClose,
    Function? onError,
  }) {
    if (adsState != AdsState.ready || ads is! RewardedAd) {
      log('Ads not ready');
      onError?.call();
      return;
    }
    updateState = AdsState.showing;
    // Call khi user đóng ads
    (ads as RewardedAd).fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        onClose?.call();
        loadAds(place);
      },
    );
    // Call ngay khi show ads
    (ads as RewardedAd).onPaidEvent = (Ad ad, double valueMicros,
        PrecisionType precision, String currencyCode) {
      onShow?.call();
      double value = valueMicros / 1000000;
      // TrackUtil.trackPaidAdEvent(
      //     ad.adUnitId, value, 'rewarded_video', currencyCode);
      // trackEvent(AdsEvent.eventNameAdsPaid, place,
      //     currency: currencyCode, revenue: value);
    };
    (ads as RewardedAd).show(
      // Call khi user có thể nhận reward (Chưa cần lick tắt quảng cáo)
      onUserEarnedReward: (adWithoutView, reward) {
        onSuccess?.call(adWithoutView, reward);
      },
    );
  }

  void trackEvent(String place, String event,
      {String currency = 'USD', double revenue = 0}) {
    // TrackUtil.trackAdsEvent(
    //     evenName: event,
    //     place: place,
    //     adUnitId: _adsId,
    //     adType: AdType.reward,
    //     currency: currency,
    //     revenue: revenue);
  }
}
