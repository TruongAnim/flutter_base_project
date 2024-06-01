import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget spaceWidth(double width, {double? height}) {
  return SizedBox(width: width, height: height);
}

Widget spaceHeight(double height, {double? width}) {
  return SizedBox(height: height, width: width);
}

mixin SizeUtil {
  static double defaultAppbarH = 40.h;

  ///
  /// Get bottom bar height.
  ///
  static double bottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }

  ///
  /// Get status bar height.
  ///
  static double statusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }
}
