import 'package:isar/isar.dart';

abstract class LocalRepo<T> {
  final Isar isar;
  final IsarCollection<T> collection;

  LocalRepo(this.isar, {required this.collection});

  Future<List<T>> getAll() {
    return collection.where().findAll();
  }

  Future<T?> get(int id) {
    return collection.get(id);
  }

  Future<int> delete(List<int> ids) async {
    int result = 0;
    await isar.writeTxn(() async {
      result = await collection.deleteAll(ids);
    });
    return result;
  }

  Future<void> clear() async {
    await isar.writeTxn(() async {
      await collection.clear();
    });
  }

  Future<int> put(T record) async {
    int id = 0;
    await isar.writeTxn(() async {
      id = await collection.put(record);
    });
    return id;
  }

  Future<List<int>> putAll(List<T> records) async {
    List<int> ids = [];
    await isar.writeTxn(() async {
      ids = await collection.putAll(records);
    });
    return ids;
  }
}
