import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class PostRepo extends RemoteRepo<PostModel> {
  PostRepo()
      : super(DioClient.I,
            endPoint: EndPoints.REMOTE_FILM, constructor: PostModel.fromMap);

  Future<ApiResponse<PostModel>> getPostByName({required String filter}) async {
    try {
      String uri = '${EndPoints.REMOTE_POST}?$filter';
      final response = await dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(PostModel.fromMap(data));
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
