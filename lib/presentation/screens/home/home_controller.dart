import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/api/api_response.dart';
import 'package:flutter_base_project/data/api/api_service.dart';
import 'package:flutter_base_project/data/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() async {
    final ApiResponse response =
        await ApiService.I.get('https://jsonplaceholder.typicode.com/todos/1');
    UserModel userModel = UserModel.fromMap(response.r as Map<String, dynamic>);
    appLog(msg: '${userModel.toMap()}');
  }
}
