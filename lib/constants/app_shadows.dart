import 'package:flutter/material.dart';

class AppShadows {
  static BoxShadow defaultShadow = BoxShadow(
    blurRadius: 3,
    color: Colors.black.withOpacity(.2),
  );

  static BoxShadow shadow1 = BoxShadow(
    blurRadius: 30,
    spreadRadius: -10,
    color: const Color(0xFF1A1A1A).withOpacity(.1),
  );

  static BoxShadow shadow2 = BoxShadow(
    blurRadius: 4,
    color: const Color(0xFF000000).withOpacity(.1),
  );

  static BoxShadow shadow3 = BoxShadow(
    blurRadius: 8,
    offset: const Offset(0, 4),
    color: const Color(0xFF1A1A1A).withOpacity(.1),
  );
}
