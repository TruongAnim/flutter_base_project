import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/base_widget/loading/ads_loading_full_screen/ads_loading_controller.dart';
import 'package:template/core/export/core_export.dart';

class AppOpenAds {
  ///
  /// Declare the API.
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();

  /// Declare the data.
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Load an AppOpenAd.
  void showOpenAppAds({
    String? idAds,
    required Function onSuccess,
    required Function onError,
  }) {
    //
    // Show dialog loading here.
    ShowAdsLoadingFullScreen.showAdsLoadingFullScreen();

    AppOpenAd.load(
      adUnitId: idAds ?? AdHelper().openAppAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;

          // Loading ads successfully.
          if (Get.isRegistered<AdsLoadingController>()) {
            Get.find<AdsLoadingController>().setTitleLoadingAds(title: 'Loading ads successfully.');
          }

          // Show full ads screen.
          showAdIfAvailable(
            idAds: idAds ?? AdHelper().openAppAdUnitId,
            callBackDismiss: () {
              onSuccess();
            },
            onAdFailed: () {
              onError();
            },
          );
        },
        onAdFailedToLoad: (error) async {
          log('AppOpenAd failed to load: $error');
          Get.back();

          // Loading ads successfully.
          if (Get.isRegistered<AdsLoadingController>()) {
            Get.find<AdsLoadingController>().setTitleLoadingAds(title: 'Loading ads error.');
          }
        },
      ),
      request: const AdRequest(),
    );
  }

  ///
  /// Load ads at splash screen.
  ///
  void loadAdsAtSplashScreen({required Function onSuccess, required Function onError}) {
    AppOpenAd.load(
      adUnitId: AdHelper().openAppAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          onSuccess();
        },
        onAdFailedToLoad: (error) {
          log('AppOpenAd failed to load: $error');

          onError();
        },
      ),
      request: const AdRequest(),
    );
  }

  ///
  /// Show full ads screen.
  ///
  void showAdIfAvailable({Function? callBackDismiss, Function? onAdFailed, String? idAds}) {
    if (_appOpenAd == null) {
      log('Tried to show ad before available.');

      // Load an AppOpenAd.
      showOpenAppAds(
        idAds: idAds,
        onSuccess: () {},
        onError: () {},
      );
      if (onAdFailed != null) {
        onAdFailed();
      }
      return;
    }
    if (_isShowingAd) {
      log('Tried to show ad while already showing an ad.');
      if (onAdFailed != null) {
        onAdFailed();
      }
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        log('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');

        // Close dialog loading ads.
        Get.back();

        _isShowingAd = false;

        ad.dispose();
        _appOpenAd = null;

        if (Platform.isAndroid) {
          _keyValidateAds.setIsShowingAdsAward(value: true);
        }

        if (onAdFailed != null) {
          onAdFailed();
        }
      },
      onAdDismissedFullScreenContent: (ad) {
        log('$ad onAdDismissedFullScreenContent');

        // Close dialog loading ads.
        Get.back();

        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;

        if (Platform.isAndroid) {
          _keyValidateAds.setIsShowingAdsAward(value: true);
        }

        if (callBackDismiss != null) {
          callBackDismiss();
        }
      },
    );

    _appOpenAd!.show();
  }
}

class AppLifecycleReactor {
  final AppOpenAds appOpenAdManager;
  final String idAds;

  AppLifecycleReactor(this.idAds, {required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable(idAds: idAds);
    }
  }
}
