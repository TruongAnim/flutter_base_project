import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/response/exports.dart';

abstract class RemoteRepo<T> {
  final DioClient dio;
  final String endPoint;
  final Function constructor;

  RemoteRepo(this.dio, {required this.endPoint, required this.constructor});

  Future<ApiResponse<List<T>>> paginate(
      {int page = 1, int limit = 10, String filter = ''}) async {
    try {
      String uri = '$endPoint/paginate?page=$page&limit=$limit$filter';
      final response = await dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data['results'] as List<dynamic>;
        return ApiResponse.success(
            data.map((e) => constructor(e) as T).toList());
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse<T>> get({required String filter}) async {
    try {
      String uri = '$endPoint?$filter';
      final response = await dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(constructor(data) as T);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse<T>> post({required dynamic input}) async {
    try {
      final response = await dio.post(endPoint, data: input);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(constructor(data) as T);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse<T>> put({required dynamic input}) async {
    try {
      final response = await dio.put(endPoint, data: input);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(constructor(data) as T);
      } else {
        return ApiResponse.error(ApiErrorHandler.getMessage(response.data));
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse<T>> delete({required String id}) async {
    try {
      String uri = '$endPoint/$id';
      final response = await dio.delete(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(constructor(data) as T);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
