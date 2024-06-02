import 'package:flutter_base_project/core/helper/common_helper.dart';
import 'package:flutter_base_project/data/data_source/isar_service.dart';
import 'package:isar/isar.dart';

import '../mapping.dart';

class LocalRepo with Mapping {
  late Isar isar;

  void registerCollection<T>(IsarCollection<T> collection) {
    registerMapping<T>(MappingType.isarCollection, collection);
  }

  IsarCollection<T> getCollection<T>() {
    return getMapping<T>(MappingType.isarCollection);
  }

  Future<void> init() async {
    isar = await IsarService().init();
  }

  Future<List<T>> getAll<T>() {
    return getCollection<T>().where().findAll();
  }

  Future<T?> get<T>(int id) {
    return getCollection<T>().get(id);
  }

  Future<int> delete<T>(List<int> ids) async {
    int result = 0;
    await isar.writeTxn(() async {
      result = await getCollection<T>().deleteAll(ids);
    });
    return result;
  }

  Future<void> clear<T>() async {
    await isar.writeTxn(() async {
      await getCollection<T>().clear();
    });
  }

  Future<int> put<T>(T record) async {
    int id = 0;
    await isar.writeTxn(() async {
      id = await getCollection<T>().put(record);
    });
    return id;
  }

  Future<List<int>> putAll<T>(List<T> records) async {
    List<int> ids = [];
    await isar.writeTxn(() async {
      ids = await getCollection<T>().putAll(records);
    });
    return ids;
  }
}
