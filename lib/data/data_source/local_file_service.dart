import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

class LocalFileService {
  LocalFileService._();
  static final LocalFileService _instance = LocalFileService._();
  static LocalFileService get instance => _instance;
  static LocalFileService get I => _instance;

  void init() {}

  Future<String> loadAsset(String uri) {
    return rootBundle.loadString(uri);
  }

  Future<List<Map<String, dynamic>>> getDataFromAsset(String uri) async {
    String data = await loadAsset(uri);
    return List<Map<String, dynamic>>.from(json.decode(data));
  }

  Future<String> loadFile(String uri) {
    return rootBundle.loadString(uri);
  }

  Future<List<Map<String, dynamic>>> getDataFromFile(String uri) async {
    try {
      final file = File(uri);
      if (await file.exists()) {
        String contents = await file.readAsString();
        return List<Map<String, dynamic>>.from(json.decode(contents));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
