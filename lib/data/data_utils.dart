import 'dart:convert';

mixin DataUtils {
  static List<Map<String, dynamic>> listStringToMap(String data) {
    return List<Map<String, dynamic>>.from(json.decode(data));
  }

  static T buildObject<T>(Function f, dynamic data) {
    return f(data) as T;
  }
}
