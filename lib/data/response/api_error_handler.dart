import 'package:dio/dio.dart';

import 'error_response.dart';

mixin ApiErrorHandler {
  static dynamic getMessage(dynamic error) {
    dynamic errorDescription = '';
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = 'Request to API server was cancelled';
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = 'Connection timeout with API server';
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  'Connection to API server failed due to internet connection';
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  'Receive timeout in connection with API server';
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  final ErrorResponse errors =
                      ErrorResponse.fromJson(error.response!.data);
                  errorDescription = errors.errors[0].detail.toString();
                  break;
                case 404:
                  final ErrorResponse errors =
                      ErrorResponse.fromJson(error.response!.data);
                  errorDescription = errors.errors[0].detail.toString();
                  break;
                case 413:
                  final ErrorResponse errors =
                      ErrorResponse.fromJson(error.response!.data);
                  errorDescription = errors.errors[0].detail.toString();
                  break;
                case 500:
                  final ErrorResponse errors =
                      ErrorResponse.fromJson(error.response!.data);
                  errorDescription = errors.errors[0].detail.toString();
                  break;
                case 503:
                  final ErrorResponse errors =
                      ErrorResponse.fromJson(error.response!.data);
                  errorDescription = errors.errors[0].detail.toString();
                  break;

                default:
                  final Errors errors = Errors.fromJson(error.response!.data);
                  if (errors.message != '') {
                    errorDescription = errors.message;
                  } else {
                    errorDescription =
                        'Failed to load data - status code: ${error.response!.statusCode}';
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = 'Send timeout with server';
              break;

            case DioExceptionType.badCertificate:
              errorDescription =
                  'Connection to API server failed due to internet connection bad Certificate';
              break;

            case DioExceptionType.connectionError:
              errorDescription = 'Connection to API server failed';
              break;
          }
        } else {
          errorDescription = 'Unexpected error occurred';
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else if (error is String) {
      errorDescription = error;
    } else {
      errorDescription = 'Not a subtype of exception: $error';
    }
    return errorDescription;
  }
}
