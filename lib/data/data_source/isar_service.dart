import 'package:flutter_base_project/data/models/exports.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  // dart run build_runner build
  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.openSync(
      [ProductLocalModelSchema],
      directory: dir.path,
      name: 'Local_Database',
    );
  }
}
