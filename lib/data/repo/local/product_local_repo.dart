import 'package:flutter_base_project/data/data_source/isar_service.dart';
import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'local_repo.dart';

class ProductLocalRepo extends LocalRepo<ProductLocalModel> {
  ProductLocalRepo()
      : super(IsarService.I.isar,
            collection: IsarService.I.isar.productLocalModels);

  Future<ApiResponse<List<ProductLocalModel>>> getProductByName(
      String name) async {
    try {
      final allProduct = await getAll();
      final result = allProduct
          .where((item) => item.name?.contains(name) ?? false)
          .toList();
      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
