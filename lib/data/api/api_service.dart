import 'package:dio/dio.dart';
import 'package:flutter_base_project/data/api/end_point.dart';

import 'api_response.dart';
import 'http_util.dart';

class ApiService {
  ApiService._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: EndPoint.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
  final Dio _dio;
  static ApiService get instance => _instance;
  static ApiService get I => _instance;

  // Constructor
  static final ApiService _instance = ApiService._internal();

  Future<ApiResponse<List>> paginate(String endPoint,
      {int page = 1, int limit = 10, String filter = ''}) async {
    try {
      String uri = '$endPoint/paginate?page=$page&limit=$limit$filter';
      final response = await _dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data['results'] as List<dynamic>;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse> get(String endPoint, {String filter = ''}) async {
    try {
      String uri = '$endPoint?$filter';
      final response = await _dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse> post(String endPoint, {required dynamic input}) async {
    try {
      final response = await _dio.post(endPoint, data: input);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse> put(String endPoint, {required dynamic input}) async {
    try {
      final response = await _dio.put(endPoint, data: input);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse> delete(String endPoint, {required String id}) async {
    try {
      String uri = '$endPoint/$id';
      final response = await _dio.delete(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
