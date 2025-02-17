import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

mixin AppConsts {
  static const bool isPoduct = false;
  static const String notiChannelId = 'channel';
  static List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];
}
