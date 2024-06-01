import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

mixin AppTheme {
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;
}
