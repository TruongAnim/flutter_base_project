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
  static double defaultAppbarH = 40;

  static late double screenWidth;
  static late double screenHeight;
  static late double statusBarHeight;
  static late double bottomBarHeight;
  static late double devicePixelRatio;
  static late bool isTablet;

  static void initialize(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    statusBarHeight = mediaQueryData.padding.top;
    bottomBarHeight = mediaQueryData.padding.bottom;
    devicePixelRatio = mediaQueryData.devicePixelRatio;
    isTablet = _isTablet(mediaQueryData);
  }

  static bool _isTablet(MediaQueryData mediaQueryData) {
    return mediaQueryData.size.shortestSide > 600;
  }
}
