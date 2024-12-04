import 'package:dio/dio.dart';

import 'app_util.dart';

mixin HttpUtil {
  static bool validateResponse(Response response) {
    return !nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! < 400;
  }
}
