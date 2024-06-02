import 'package:flutter/services.dart' show rootBundle;

import '../data_utils.dart';

class LocalFileService {
  Future<String> loadAssetFile(String uri) {
    return rootBundle.loadString(uri);
  }

  Future<List<Map<String, dynamic>>> getDataFromAsset(String uri) async {
    String data = await loadAssetFile(uri);
    return DataUtils.listStringToMap(data);
  }
}
