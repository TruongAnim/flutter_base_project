import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/film_model.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class FilmRepo {
  final RemoteRepo remoteRepo;
  FilmRepo(this.remoteRepo) {
    remoteRepo.registerEndPoint<FilmModel>(EndPoints.REMOTE_FILM);
    remoteRepo.registerConstructor<FilmModel>(FilmModel.fromMap);
  }

  Future<void> getAllShort({
    required String filter,
    required Function(List<FilmModel> results) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    String uri = '${EndPoints.REMOTE_FILM}?$filter';

    try {
      response = await remoteRepo.dio.get(uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (HttpUtil.validateResponse(response)) {
      final data = response.data['data'] as List<dynamic>;
      onSuccess(data.map((e) => FilmModel.fromMap(e)).toList());
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
