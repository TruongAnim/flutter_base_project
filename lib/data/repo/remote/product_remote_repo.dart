import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class ProductRemoteRepo {
  final RemoteRepo remoteRepo;
  ProductRemoteRepo(this.remoteRepo) {
    remoteRepo.registerEndPoint<ProductModel>(EndPoints.REMOTE_PRODUCT);
    remoteRepo.registerConstructor<ProductModel>(ProductModel.fromMap);
  }

  Future<void> getProductByName({
    required String filter,
    required Function(ProductModel results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${remoteRepo.getEndPoint<ProductModel>()}?$filter';

    try {
      response = await remoteRepo.dio.get(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(ProductModel.fromMap(data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
