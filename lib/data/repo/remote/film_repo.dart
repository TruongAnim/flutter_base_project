import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/film_model.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class FilmRepo extends RemoteRepo<FilmModel> {
  FilmRepo()
      : super(DioClient.I,
            endPoint: EndPoints.REMOTE_FILM, constructor: FilmModel.fromMap);

  Future<ApiResponse<List<FilmModel>>> getAllShort(
      {required String filter}) async {
    try {
      String uri = '${EndPoints.REMOTE_FILM}?$filter';
      final response = await dio.get(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data['data'] as List<dynamic>;
        return ApiResponse.success(
            data.map((e) => FilmModel.fromMap(e)).toList());
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
