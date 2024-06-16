import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/shared_preference/exports.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;

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

  static bool isWithinOneWeek(DateTime date) {
    final DateTime now = DateTime.now();
    final int differenceInDays = date.difference(now).inDays;
    return differenceInDays >= 0 && differenceInDays <= 7;
  }

  ///
  /// Calculate age.
  ///
  static int calculateAge(DateTime birthDate) {
    final DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  ///
  /// Customer display time ago.
  ///
  static String timeAgo(DateTime date, {String format = 'HH:mm dd-MM-yyyy'}) {
    //
    // Convert to dd-MM-yyyy.
    // time_ago.setLocaleMessages('vi', time_ago.ViMessages());
    final String passDate = DateFormat('dd-MM-yyyy').format(date);
    final DateTime convertPassDate = DateFormat('dd-MM-yyyy').parse(passDate);
    final DateTime now = DateTime.now();
    final local = appGlobal<SharedPreferenceHelper>().getLocale;
    if (now.difference(convertPassDate).inDays > 0) {
      return DateFormat(local == 'en' ? format : 'MMM d, y h:mm a')
          .format(date);
    }

    return time_ago.format(date, locale: local);
  }
}
