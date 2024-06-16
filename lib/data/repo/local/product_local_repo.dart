import 'package:flutter_base_project/data/models/exports.dart';

import 'local_repo.dart';

class ProductLocalRepo {
  final LocalRepo localRepo;
  ProductLocalRepo(this.localRepo) {
    localRepo.registerCollection<ProductLocalModel>(
        localRepo.isar.productLocalModels);
  }

  Future<void> getAll(
      {required Function(List<ProductLocalModel>) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      onSuccess(await localRepo.getAll<ProductLocalModel>());
    } catch (e) {
      onError(e);
    }
  }

  Future<void> getProductByName(
      String name,
      Function(List<ProductLocalModel>) onSuccess,
      Function(dynamic onError) onError) async {
    try {
      final allProduct = await localRepo.getAll<ProductLocalModel>();
      onSuccess(allProduct
          .where((item) => item.name?.contains(name) ?? false)
          .toList());
    } catch (e) {
      onError(e);
    }
  }
}
