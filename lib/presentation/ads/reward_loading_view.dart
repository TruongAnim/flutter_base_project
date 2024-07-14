import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/services/ads/exports.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardLoadingShowView extends StatefulWidget {
  final String place;
  final Function(RewardItem?)? callback;

  const RewardLoadingShowView({
    super.key,
    required this.place,
    this.callback,
  });

  @override
  State<StatefulWidget> createState() => _RewardLoadingShowViewState();
}

class _RewardLoadingShowViewState extends State<RewardLoadingShowView> {
  StreamSubscription? _streamSubscription;
  final RewardAdsService _rewardAdsService = appGlobal<RewardAdsService>();
  final loadAdLimitedConfig = 10;
  Timer? _countDownTimer;
  Timer? _reloadTimer;
  bool isShowed = false;

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  void _loadAds() {
    if (_rewardAdsService.adsState == AdsState.ready) {
      showAds();
    } else {
      _streamSubscription =
          _rewardAdsService.stateStream.stream.listen((state) {
        if (state == AdsState.ready && mounted) {
          showAds();
        }
      });
      reloadAds();
      _reloadTimer = Timer(const Duration(seconds: 5), () {
        if (!isShowed) {
          reloadAds();
        }
      });
      _countDownTimer = Timer(Duration(seconds: loadAdLimitedConfig), () {
        if (!isShowed) {
          _nextAction(null, null);
        }
      });
    }
  }

  void reloadAds() {
    if (_rewardAdsService.adsState == AdsState.error) {
      _rewardAdsService.loadAds(widget.place);
    }
  }

  void showAds() {
    if (isShowed) return;
    isShowed = true;
    AdWithoutView? adWithoutView;
    RewardItem? rewardItem;
    _rewardAdsService.showAds(
        place: widget.place,
        onSuccess: (AdWithoutView? view, RewardItem? reward) {
          adWithoutView = view;
          rewardItem = reward;
        },
        onClose: () {
          _nextAction(adWithoutView, rewardItem);
        },
        onError: () {
          _nextAction(null, null);
        });
  }

  @override
  void dispose() {
    _countDownTimer?.cancel();
    _streamSubscription?.cancel();
    _reloadTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(color: Colors.green),
            const SizedBox(height: 100),
            Text('loading_ads'.tr,
                style: Theme.of(context).textTheme.labelMedium)
          ],
        ),
      ),
    );
  }

  Future<void> _nextAction(
      AdWithoutView? adWithoutView, RewardItem? rewardItem) async {
    _countDownTimer?.cancel();
    Navigator.of(context).pop();
    widget.callback?.call(rewardItem);
  }
}
