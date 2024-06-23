import 'package:flutter/material.dart';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  visualDensity: const VisualDensity(
      vertical: VisualDensity.minimumDensity,
      horizontal: VisualDensity.minimumDensity),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: AppColors.BACK_GROUND,
  fontFamily: 'Nunito',
  primaryColor: AppColors.PRIMARY_1, // Màu chủ đạo
  brightness: Brightness.light,
  hintColor: Colors.red,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),
  dividerTheme: DividerThemeData(color: Colors.white.withOpacity(.2)),
  radioTheme: _radioThemeData(),
  bottomSheetTheme: _bottomSheetThemeData(),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  filledButtonTheme: _filledButtonThemeData(),
  iconButtonTheme: _iconButtonThemeData(),
  elevatedButtonTheme: _elevatedButtonThemeData(),
  textButtonTheme: _textButtonThemeData(),
  outlinedButtonTheme: _outlineButtonThemData(),

  textTheme: TextTheme(
    // Các các tiêu đề rất lớn.
    displayLarge: TextStyle(
      fontSize: 30.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 24.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 22.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),

    // Cho các label của button. label của input
    labelLarge: TextStyle(
      fontSize: 20.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 18.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: 16.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),

    // Phần nội dung.
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),

    // Cho nội dung bình thường và mặc định.
    bodyMedium: TextStyle(
      fontSize: 12.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: Colors.yellow,
    ),
    bodySmall: TextStyle(
      fontSize: 10.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
  ),
);

///
/// Filled button theme data.
///
FilledButtonThemeData _filledButtonThemeData() {
  return FilledButtonThemeData(
    style: _buttonStyle(
      backgroundColor: AppColors.PRIMARY_1,
    ),
  );
}

///
/// Icon button them data.
///
IconButtonThemeData _iconButtonThemeData() {
  return IconButtonThemeData(
    style: _buttonStyle(),
  );
}

///
/// Radio theme data.
///
RadioThemeData _radioThemeData() {
  return RadioThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      return AppColors.PRIMARY_4;
    }),
    visualDensity: VisualDensity.comfortable,
  );
}

///
/// Bottom sheet theme data.
///
BottomSheetThemeData _bottomSheetThemeData() {
  return const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
    elevation: 0,
  );
}

///
/// Elevated button theme data.
///
ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: _buttonStyle(
      elevation: 0,
      backgroundColor: AppColors.PRIMARY_1,
      textColor: Colors.black87,
    ),
  );
}

///
/// Text button theme data.
///
TextButtonThemeData _textButtonThemeData() {
  return TextButtonThemeData(
    style: _buttonStyle(
      textColor: AppColors.PRIMARY_1,
    ),
  );
}

///
/// Out line button theme data.
///
OutlinedButtonThemeData _outlineButtonThemData() {
  return OutlinedButtonThemeData(
    style: _buttonStyle(
      borderSide: const BorderSide(
        color: AppColors.PRIMARY_1,
        width: 2,
      ),
      textColor: AppColors.PRIMARY_1,
    ),
  );
}

/// ButtonStyle.
ButtonStyle _buttonStyle({
  BorderSide? borderSide,
  double? elevation,
  Color? backgroundColor,
  Color? textColor,
}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    foregroundColor: MaterialStateProperty.all(textColor),
    elevation: MaterialStateProperty.all(elevation ?? 0.0),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    textStyle: MaterialStatePropertyAll(TextStyle(
      fontSize: 18.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    )),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    side: MaterialStatePropertyAll(borderSide),
  );
}
