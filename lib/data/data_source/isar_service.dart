import 'package:flutter_base_project/data/models/exports.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  IsarService._();
  static final IsarService _instance = IsarService._();
  static IsarService get instance => _instance;
  static IsarService get I => _instance;

  bool isInit = false;
  late final Isar isar;

  // dart run build_runner build
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isInit = true;
    isar = await Isar.open(
      [ProductLocalModelSchema],
      directory: dir.path,
      name: 'Local_Database',
    );
  }
}
