import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class PostRepo {
  final RemoteRepo remoteRepo;
  PostRepo(this.remoteRepo) {
    remoteRepo.registerEndPoint<PostModel>(EndPoints.REMOTE_POST);
    remoteRepo.registerConstructor<PostModel>(PostModel.fromMap);
  }

  Future<void> getPostByName({
    required String filter,
    required Function(PostModel results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${EndPoints.REMOTE_POST}?$filter';

    try {
      response = await remoteRepo.dio.get(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (ValidatorHelper.validateResponse(response)) {
      final data = response.data as Map<String, dynamic>;
      onSuccess(PostModel.fromMap(data));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
