import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base_widgets/exports.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    this.isShowBack = false,
    this.isShowDivider = true,
    this.includeStatusBar = true,
    required this.title,
    this.icBack = AppImages.icBack,
    this.trailing,
    this.onBack,
    this.height,
  });
  final bool isShowBack;
  final bool isShowDivider;
  final bool includeStatusBar;
  final String title;
  final String icBack;
  final Widget? trailing;
  final double? height;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: height ?? 44.h,
      margin: includeStatusBar
          ? EdgeInsets.only(top: SizeUtil.statusBarHeight())
          : null,
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        border: isShowDivider
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.WIDGET_BG,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onBack,
            child: Container(
              alignment: Alignment.center,
              width: 0.17.sw,
              child: isShowBack
                  ? ImageWidget(icBack, width: 24.h, height: 24.h)
                  : null,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              title,
              maxLines: 1,
              stepGranularity: 1.sp,
              minFontSize: 6.sp,
              style: TextStyle(
                color: AppColors.Neutral_8,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 0.17.sw,
            child: trailing,
          ),
        ],
      ),
    );
  }
}
