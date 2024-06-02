import 'package:flutter_base_project/data/models/exports.dart';

import 'local_repo.dart';

class ProductLocalRepo {
  final LocalRepo localRepo;
  ProductLocalRepo(this.localRepo) {
    localRepo.registerCollection<ProductModel>(localRepo.isar.productModels);
  }

  Future<void> getAll(
      {required Function(List<ProductModel>) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      onSuccess(await localRepo.getAll<ProductModel>());
    } catch (e) {
      onError(e);
    }
  }

  Future<void> getProductByName(
      String name,
      Function(List<ProductModel>) onSuccess,
      Function(dynamic onError) onError) async {
    try {
      final allProduct = await localRepo.getAll<ProductModel>();
      onSuccess(allProduct
          .where((item) => item.name?.contains(name) ?? false)
          .toList());
    } catch (e) {
      onError(e);
    }
  }
}
