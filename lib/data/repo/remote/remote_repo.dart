import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/data_utils.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import '../mapping.dart';

class RemoteRepo with Mapping {
  DioClient dio;

  RemoteRepo(this.dio);

  void registerEndPoint<T>(String endPoint) {
    registerMapping<T>(MappingType.remoteEndPoint, endPoint);
  }

  String getEndPoint<T>() {
    return getMapping<T>(MappingType.remoteEndPoint);
  }

  void registerConstructor<T>(Function f) {
    registerMapping<T>(MappingType.constructor, f);
  }

  Function getConstructor<T>() {
    return getMapping<T>(MappingType.constructor);
  }

  Future<void> paginate<T>({
    int page = 1,
    int limit = 10,
    String filter = '',
    required Function(List<T> results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${getEndPoint<T>()}/paginate?page=$page&limit=$limit$filter';
    try {
      response = await dio.get(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data['results'] as List<dynamic>;
      onSuccess(data
          .map((e) => DataUtils.buildObject<T>(getConstructor<T>(), e))
          .toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> get<T>({
    required String filter,
    required Function(T results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${getEndPoint<T>()}?$filter';

    try {
      response = await dio.get(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(DataUtils.buildObject<T>(getConstructor<T>(), data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> post<T>({
    required dynamic input,
    required Function(T results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = getEndPoint<T>();

    try {
      response = await dio.post(uri, data: input);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(DataUtils.buildObject<T>(getConstructor<T>(), data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> put<T>({
    required dynamic input,
    required Function(T results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = getEndPoint<T>();

    try {
      response = await dio.put(uri, data: input);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(DataUtils.buildObject<T>(getConstructor<T>(), data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> delete<T>({
    required String id,
    required Function(T results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${getEndPoint<T>()}/$id';

    try {
      response = await dio.delete(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(DataUtils.buildObject<T>(getConstructor<T>(), data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
