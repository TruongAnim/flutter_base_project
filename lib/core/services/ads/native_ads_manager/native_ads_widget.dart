import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../export/core_export.dart';

class NativeAdsWidget extends StatefulWidget {
  const NativeAdsWidget({
    super.key,
    this.isKeepAlive = true,
    this.callBack,
    this.templateType = TemplateType.medium,
    this.backGround = ColorResources.PRIMARY_1,
    this.idAds,
    this.onError,
  });
  final bool? isKeepAlive;
  final Function? callBack;
  final Function? onError;
  final TemplateType? templateType;
  final Color? backGround;
  final String? idAds;

  @override
  State<NativeAdsWidget> createState() => _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> with AutomaticKeepAliveClientMixin {
  //
  // Native ads.
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  bool _isNoAdsShow = false;

  @override
  void initState() {
    log('TechMind hello ${widget.idAds} || ${AdHelper().nativeAdUnitId} ');
    _nativeAd = NativeAd(
      adUnitId: widget.idAds ?? AdHelper().nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          log('$NativeAd loaded.');
          _nativeAdIsLoaded = true;
          setState(() {});

          if (widget.callBack != null) {
            widget.callBack!();
          }
        },
        onAdFailedToLoad: (ad, error) async {
          log('$NativeAd failedToLoad: $error');
          ad.dispose();
          _nativeAdIsLoaded = true;
          _isNoAdsShow = true;
          setState(() {});

          if (widget.onError != null) {
            widget.onError!();
          }
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType!,
        mainBackgroundColor: widget.backGround,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: ColorResources.PRIMARY_1,
          backgroundColor: ColorResources.PRIMARY_4,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: ColorResources.PRIMARY_1,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: const Color(0xFF666666),
          backgroundColor: Colors.transparent,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: ColorResources.WHITE,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
      ),
    )..load();
    super.initState();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_nativeAdIsLoaded) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 320,
          minHeight: widget.templateType == TemplateType.medium ? 120 : 90,
          maxWidth: widget.templateType == TemplateType.medium ? 360 : 360,
          maxHeight: widget.templateType == TemplateType.medium ? 360 : 120,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.backGround,
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingApp(
                titleLoading: 'Loading ads...',
                size: widget.templateType == TemplateType.medium ? null : IZISizeUtil.setSizeWithHeight(percent: .075),
                sizeLogo:
                    widget.templateType == TemplateType.medium ? null : IZISizeUtil.setSizeWithHeight(percent: .04),
              ),
            ],
          ),
        ),
      );
    }

    if (_nativeAdIsLoaded && _isNoAdsShow) {
      return const SizedBox.shrink();
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 320,
        minHeight: widget.templateType == TemplateType.medium ? 120 : 90,
        maxWidth: widget.templateType == TemplateType.medium ? 360 : 360,
        maxHeight: widget.templateType == TemplateType.medium ? 360 : 120,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
          color: widget.backGround,
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
            child: AdWidget(ad: _nativeAd!),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.isKeepAlive!;
}
