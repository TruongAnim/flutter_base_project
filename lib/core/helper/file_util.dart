import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/global/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

mixin FileUtil {
  static String byteToString(int bytes, {int? decimals = 2}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals!)} ${suffixes[i]}';
  }

  static Future<String> getFileSize(String filepath,
      {int? decimals = 2}) async {
    final file = File(filepath);
    final int bytes = await file.length();
    return byteToString(bytes, decimals: decimals);
  }

  static Future<String?> downloadFile(String url, String? fileName,
      Function(int, int) onReceiveProgress) async {
    try {
      Dio dio = appGlobal<DioClient>().dio!;
      var dir = await getApplicationDocumentsDirectory();
      String savePath =
          "${dir.path}/${fileName ?? 'Download_${DateTime.now().microsecondsSinceEpoch}'}";

      await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
      return savePath;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> httpDownloadFile(String url, String? fileName) async {
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      final String savePath =
          "${dir.path}/${fileName ?? 'Download_${DateTime.now().microsecondsSinceEpoch}'}";
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
      return savePath;
    } catch (e) {
      return null;
    }
  }
}
