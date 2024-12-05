import 'api_error_handler.dart';

class ApiResponse<T> {
  final T? r;
  final dynamic e;

  ApiResponse({required this.r, required this.e});

  factory ApiResponse.error(dynamic e) {
    return ApiResponse(r: null, e: ApiErrorHandler.getMessage(e));
  }

  factory ApiResponse.success(T r) {
    return ApiResponse(r: r, e: null);
  }
}
