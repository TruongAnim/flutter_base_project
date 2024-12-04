import 'dart:convert';

import 'app_util.dart';

extension TranslateExtensions on String? {
  String get tran {
    try {
      if (this != null && this!.isNotEmpty) {
        final map = json.decode(this!);
        if (map is Map<String, dynamic>) {
          return map[appLocal] ?? map['en'];
        }
      }
      return '';
    } catch (e) {
      return toString();
    }
  }
}

mixin StringUtil {
  static String? mapToString(dynamic data) {
    if (data == null) {
      return null;
    }
    if (data is Map<String, dynamic>) {
      return json.encode(data);
    }
    return data.toString();
  }

  static List<String> toListString(dynamic data) {
    if (data is List) {
      return data.map((e) => mapToString(e) ?? '').toList();
    }
    return [];
  }
}
