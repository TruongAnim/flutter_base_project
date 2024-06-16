import 'package:flutter_base_project/data/data_utils.dart';
import 'package:flutter_base_project/data/models/exports.dart';

import '../data_source/local_file_service.dart';
import '../domain/end_points.dart';
import 'mapping.dart';

class LocalFileRepo with Mapping {
  final LocalFileService _localFileRepo = LocalFileService();

  void init() async {
    registerMapping<ProductLocalModel>(
        MappingType.localEndPoint, EndPoints.LOCAL_PRODUCT);

    registerMapping<ProductLocalModel>(
        MappingType.constructor, ProductLocalModel.fromMap);
  }

  Future<List<T>> getAll<T>() async {
    final List<dynamic> response = await _localFileRepo
        .getDataFromAsset(getMapping<T>(MappingType.localEndPoint));
    return response.map((e) {
      return DataUtils.buildObject<T>(
          getMapping<T>(MappingType.constructor), e);
    }).toList();
  }
}
