import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:intl/intl.dart' as intl;

mixin DateTimeHelper {
  static String format_1 = "yyyy-MM-dd hh:mm:ss";
  static String format_2 = "HH:mm dd-MM-yyyy";
  static String format_3 = "dd MMM yyyy";
  static String format_4 = "dd-MM-yyyy";
  static String format_5 = "dd/MM/yyyy";
  static String format_6 = "hh:mm";
  static String format_7 = "yyyy-MM-dd";
  static String format_8 = "MMM dd, yyyy";

  static String formatDate(DateTime dateTime, {String format = "dd/MM/yyyy"}) {
    return intl.DateFormat(
            format, appGlobal<SharedPreferenceHelper>().getLocale)
        .format(dateTime);
  }

  static String intToString(int dateTime, {String format = "dd/MM/yyyy"}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(dateTime),
        format: format);
  }
}
