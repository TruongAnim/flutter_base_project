// import 'package:base_project/core/global/di_container.dart';
// import 'package:base_project/data/models/course_overview_section.dart';
// import 'package:base_project/data/models/exports.dart';
// import 'package:base_project/data/models/video_model.dart';
// import 'package:base_project/data/repo/exports.dart';

// class InitDataHelper {
//   final _isarRepo = appGlobal<IsarRepo>();
//   final _dioRepo = appGlobal<DioRepo>();
//   Future<void> initData() async {
//     List<Future<void>> futures = [
//       initDataFromJson<ProductModel>(),
//     ];
//     await Future.wait(futures);
//   }

//   Future<void> initDataFromJson<T>() async {
//     // delete all exist T
//     await _isarRepo.clear<T>();
//     // get T from remote
//     List<T> record = [];
//     record = await _dioRepo.getAll<T>();
//     // insert new T to local db
//     _isarRepo.putAll<T>(record);
//   }
// }
