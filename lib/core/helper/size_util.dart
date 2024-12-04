import 'package:flutter/material.dart';

Widget spaceWidth(double width, {double? height}) {
  return SizedBox(width: width, height: height);
}

Widget spaceHeight(double height, {double? width}) {
  return SizedBox(height: height, width: width);
}

double get sw => SizeUtil.screenWidth;
double get sh => SizeUtil.screenHeight;

mixin SizeUtil {
  static const double defaultAppbarH = 40;

  static late final double screenWidth;
  static late final double screenHeight;
  static late final double defaultSize;
  static late final double statusBarHeight;
  static late final double bottomBarHeight;
  static late final double devicePixelRatio;
  static late final bool isTablet;

  static void initialize(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    defaultSize = 0.1 * screenHeight;
    statusBarHeight = mediaQueryData.padding.top;
    bottomBarHeight = mediaQueryData.padding.bottom;
    devicePixelRatio = mediaQueryData.devicePixelRatio;
    isTablet = _isTablet(mediaQueryData);
  }

  static bool _isTablet(MediaQueryData mediaQueryData) {
    return mediaQueryData.size.shortestSide > 600;
  }
}
