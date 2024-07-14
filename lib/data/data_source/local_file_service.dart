import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

import '../data_utils.dart';

class LocalFileService {
  Future<String> loadAsset(String uri) {
    return rootBundle.loadString(uri);
  }

  Future<List<Map<String, dynamic>>> getDataFromAsset(String uri) async {
    String data = await loadAsset(uri);
    return DataUtils.listStringToMap(data);
  }

  Future<String> loadFile(String uri) {
    return rootBundle.loadString(uri);
  }

  Future<List<Map<String, dynamic>>> getDataFromFile(String uri) async {
    try {
      final file = File(uri);
      if (await file.exists()) {
        String contents = await file.readAsString();
        return DataUtils.listStringToMap(contents);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
