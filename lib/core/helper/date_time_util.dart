import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'app_util.dart';

mixin DateTimeUtil {
  static String getTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String second = time.second.toString().padLeft(2, '0');

    return "$hour:$minute:$second";
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static DateTime intToDate(int time) {
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  static int milliSinceMidnight() {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    Duration difference = now.difference(startOfToday);
    return difference.inMilliseconds;
  }

  static int get timeStamp => DateTime.now().millisecondsSinceEpoch;

  static int diffInSecond(int target) {
    DateTime targetTime = DateTime.fromMillisecondsSinceEpoch(target);
    Duration difference = targetTime.difference(DateTime.now());
    return difference.inSeconds;
  }

  static String formatDate(DateTime dateTime, {String format = "dd/MM/yyyy"}) {
    return DateFormat(format, appLocal).format(dateTime);
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
    final local = appLocal;
    if (now.difference(convertPassDate).inDays > 0) {
      return DateFormat(local == 'en' ? format : 'MMM d, y h:mm a')
          .format(date);
    }

    return time_ago.format(date, locale: local);
  }

  static int startDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 1)
        .millisecondsSinceEpoch;
  }

  static int endDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59)
        .millisecondsSinceEpoch;
  }

  static String durationToTime(Duration duration, {bool isShowHour = false}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0 && !isShowHour) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
