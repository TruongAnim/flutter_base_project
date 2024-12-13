import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/helper/exports.dart';

mixin HttpUtil {
  static bool validateResponse(Response response) {
    return !nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! < 400;
  }
}
