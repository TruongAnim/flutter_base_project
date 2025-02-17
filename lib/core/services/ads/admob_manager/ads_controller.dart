import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AdsState {
  init,
  loading,
  ready,
  showing,
  error,
}

abstract class AdsController {
  AdWithoutView? ads;
  late String adsId;
  int retryLoad = 2;
  final Rx<AdsState> _adsState = Rx<AdsState>(AdsState.init);
  get adsState => _adsState;
  set updateState(AdsState newAdsState) {
    _adsState.value = newAdsState;
  }

  void init();
  Future<AdsState> loadAds(String place);
  void showAds({
    required String place,
    Function? onSuccess,
    Function? onShow,
    Function? onClose,
    Function? onError,
  });
}
