import 'api_error_handler.dart';

class ApiResponse<T> {
  final T? r;
  final dynamic e;
  final String? token;

  ApiResponse({required this.r, required this.e, this.token});

  factory ApiResponse.error(dynamic e) {
    return ApiResponse(r: null, e: ApiErrorHandler.getMessage(e));
  }

  factory ApiResponse.success(T r, {String? token}) {
    return ApiResponse(r: r, e: null, token: token);
  }

  @override
  String toString() {
    return '$runtimeType=> r: $r, e: $e, token: $token';
  }
}
