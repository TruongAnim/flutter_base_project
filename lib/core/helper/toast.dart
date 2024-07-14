import 'dart:ui';

import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white, // Text color of the toast message
  );
}

void showToastMessageLong(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    // Duration of the toast
    gravity: ToastGravity.BOTTOM,
    // Position of the toast
    timeInSecForIosWeb: 1,
    // Time in seconds for iOS and web
    backgroundColor: Colors.black,
    // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
  );
}

class AppSnackBar {
  AppSnackBar._();

  static void showSnackBar(
    BuildContext context,
    String text, {
    double? height,
    String? highLightText,
    SnackBarType? type,
    double? position,
  }) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          top: MediaQuery.of(context).viewPadding.top + (position ?? 0),
          child: _SnackBar(
              snackPosition: SnackBarPositioned.top,
              height: height,
              text: text,
              highlightText: highLightText,
              type: type ?? SnackBarType.success,
              dismiss: () {
                overlayEntry?.remove();
              }));
    });
    overlayState.insert(overlayEntry);
  }

  static void showSnackBottom(
    BuildContext context,
    String text, {
    double? height,
    String? highLightText,
    SnackBarType? type,
    double? position,
  }) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewPadding.bottom + (position ?? 0),
          child: _SnackBar(
              snackPosition: SnackBarPositioned.bottom,
              height: height,
              text: text,
              highlightText: highLightText,
              type: type ?? SnackBarType.success,
              dismiss: () {
                overlayEntry?.remove();
              }));
    });
    overlayState.insert(overlayEntry);
  }
}

enum SnackBarType { success, error, warning }

enum SnackBarPositioned { top, bottom }

class _SnackBar extends StatefulWidget {
  final Function? dismiss;
  final String text;
  final String? highlightText;
  final double? height;
  final SnackBarType type;
  final SnackBarPositioned snackPosition;

  const _SnackBar({
    this.dismiss,
    required this.text,
    this.height,
    this.highlightText,
    required this.snackPosition,
    required this.type,
  });

  @override
  State<_SnackBar> createState() => _SnackBarState();
}

class _SnackBarState extends State<_SnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _textSpan = <TextSpan>[];

  @override
  void initState() {
    super.initState();

    initTextSpan();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (!_controller.isDismissed) finishingAnimation();
    });
  }

  void finishingAnimation() {
    _controller.reverse().then((value) => widget.dismiss?.call());
  }

  void initTextSpan() {
    if (widget.highlightText != null) {
      final value = widget.text.split(widget.highlightText!);

      for (var item in value) {
        _textSpan.add(TextSpan(text: item, style: AppTextStyles.body1));
      }

      _textSpan.insert(
          1, TextSpan(text: widget.highlightText, style: AppTextStyles.body1));
    } else {
      _textSpan.add(TextSpan(text: widget.text, style: AppTextStyles.body1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget icon;
    switch (widget.type) {
      case SnackBarType.success:
        icon = SvgPicture.asset(AppImages.ic_tick_circle_success,
            width: 24, height: 24);
        // color = AppColor.success50;
        break;
      case SnackBarType.error:
        icon = SvgPicture.asset(AppImages.close_circle, width: 24, height: 24);
        // color = AppColor.error50;
        break;
      case SnackBarType.warning:
        icon =
            SvgPicture.asset(AppImages.ic_repeat_circle, width: 24, height: 24);
        // color = AppColor.error50;
        break;
    }
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          final double animationValue =
              Curves.ease.transform(_controller.value);
          return FractionalTranslation(
            translation: Offset(
                0,
                widget.snackPosition == SnackBarPositioned.top
                    ? -(1 - animationValue)
                    : (1 - animationValue)),
            child: ClipRRect(
              child: BackdropFilter(
                // Áp dụng BackdropFilter để làm mờ nền
                filter:
                    ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Điều chỉnh độ mờ
                child: child,
              ),
            ),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: widget.height,
            width: Get.width - 32,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF292D32).withOpacity(0.32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon.marginOnly(right: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        style: AppTextStyles.body1, children: _textSpan),
                  ).marginOnly(left: 8),
                ),
              ],
            ),
          ),
        )).marginSymmetric(horizontal: 16);
  }
}
