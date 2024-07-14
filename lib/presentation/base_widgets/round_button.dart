import 'package:flutter/material.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.width,
    this.height,
    this.paddingH,
    this.paddingV,
    this.fontSize,
    this.isFill = true,
    this.isActive = true,
    this.isGradient = true,
    this.icon,
    required this.callback,
    required this.title,
    this.subTitle,
    this.loading,
  });
  final double? width;
  final double? height;
  final double? paddingH;
  final double? paddingV;
  final double? fontSize;
  final bool isFill;
  final bool isActive;
  final bool isGradient;
  final Function() callback;
  final String title;
  final Widget? icon;
  final String? subTitle;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    Color? getColor() {
      if (isFill && isActive && !isGradient) {
        return AppColors.PRIMARY_63;
      }
      if (!isActive) {
        return AppColors.Neutral_88;
      }
      return null;
    }

    Gradient? getGradient() {
      if (isFill && isActive && isGradient) {
        return const LinearGradient(
            colors: [AppColors.LIGHT_BLUE, AppColors.PRIMARY_1]);
      }
      return null;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (isActive) {
          callback();
        }
      },
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
            vertical: paddingV ?? 0, horizontal: paddingH ?? 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height ?? 0.1 * sh),
          border:
              isFill ? null : Border.all(width: 2, color: AppColors.PRIMARY_1),
          gradient: getGradient(),
          color: getColor(),
        ),
        child: Center(
          child: loading != null && loading == true
              ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) icon!,
                        Text(
                          title,
                          style: TextStyle(
                            color:
                                isFill ? AppColors.WHITE : AppColors.PRIMARY_1,
                            fontSize: fontSize ?? 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (subTitle != null)
                      Text(
                        subTitle!,
                        style: AppTextStyles.toolTip.apply(color: Colors.white),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
