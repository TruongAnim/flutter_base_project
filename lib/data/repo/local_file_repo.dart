import 'package:flutter_base_project/data/response/exports.dart';

import '../data_source/local_file_service.dart';

class LocalFileRepo {
  final LocalFileService _localFileRepo = LocalFileService.instance;

  Future<ApiResponse<List<T>>> getAll<T>(
      String path, Function constructor) async {
    try {
      final List<dynamic> response =
          await _localFileRepo.getDataFromAsset(path);
      final result = response.map((e) {
        return constructor(e) as T;
      }).toList();
      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
