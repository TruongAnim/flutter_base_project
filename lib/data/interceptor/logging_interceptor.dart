import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/core/helper/exports.dart';

import '../data_source/dio_client.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  static const String tag = 'LoggingInterceptor';
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      final int iterations =
          (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        // print( responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print('Data ${response.data}');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    appLog(
        tag: tag,
        msg:
            'ERROR [${err.response?.statusCode}] Message[${err.response?.data}] => PATH: ${err.requestOptions.path}');
    String tokenInvalid = '';
    if (!nullOrEmpty(err.response?.data['errors'])) {
      if ((err.response?.data['errors'][0] as Map<String, dynamic>)
          .containsKey('detail')) {
        tokenInvalid =
            err.response?.data['errors'][0]['detail'].toString() ?? '';
      }
    }
    if (err.response != null) {
      if (err.response!.statusCode != null) {
        if (err.response!.statusCode! >= 400 &&
            err.response!.statusCode! <= 500 &&
            tokenInvalid == 'jwt expired') {
          final dio = appGlobal<DioClient>();
          await dio.refreshTokenExpiration();
          return handler.resolve(await dio.reTry(err.requestOptions));
        }
      }
    }
    return handler.next(err);
  }
}
