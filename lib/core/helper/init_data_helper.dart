import 'package:flutter_base_project/data/models/exports.dart';
import 'package:flutter_base_project/data/repo/local/exports.dart';
import 'package:flutter_base_project/data/repo/local_file_repo.dart';

import '../global/exports.dart';

class InitDataHelper {
  final _localRepo = appGlobal<LocalRepo>();
  final _localFileRepo = appGlobal<LocalFileRepo>();

  Future<void> initData() async {
    List<Future<void>> futures = [
      _initDataFromJson<ProductLocalModel>(),
    ];
    await Future.wait(futures);
  }

  Future<void> _initDataFromJson<T>() async {
    // delete all exist T
    await _localRepo.clear<T>();
    // get T from remote
    List<T> record = [];
    record = await _localFileRepo.getAll<T>();
    // insert new T to local db
    _localRepo.putAll<T>(record);
  }
}
