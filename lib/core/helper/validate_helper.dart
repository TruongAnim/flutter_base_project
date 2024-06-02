import 'package:dio/dio.dart';

bool nullOrEmpty(dynamic value) {
  if (value == null ||
      value.toString().trim().isEmpty ||
      value.toString() == 'null' ||
      value.toString() == '{}' ||
      (value is List && value.isEmpty == true)) return true;
  return false;
}

bool notNullOrEmpty(dynamic value) {
  return !nullOrEmpty(value);
}

mixin ValidatorHelper {
  static bool validateResponse(Response response) {
    return nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300;
  }
}
