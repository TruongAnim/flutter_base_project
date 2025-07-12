import 'dart:async';
import 'package:flutter_base_project/core/global/di_container.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/core/shared_preference/shared_pref.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/models/user_model.dart';
import 'package:flutter_base_project/data/repo/remote/auth_repo.dart';
import 'package:flutter_base_project/data/response/api_response.dart';
import 'package:flutter_base_project/tracking/exports.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tag = 'AuthController';
  final AuthRepo _authRepo = appGlobal<AuthRepo>();

  Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isLoggin = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> login() async {
    try {
      if (notNullOrEmpty(SharedPref.I.getJwtToken)) {
        final response = await _authRepo.getUserInfo();
        return _handleLoginResponse(response, isLogin: false);
      } else {
        final response = await _authRepo.login();
        return _handleLoginResponse(response);
      }
    } catch (e) {
      appLog(tag: tag, msg: e);
      isLoggin.value = true;
      return false;
    }
  }

  Future<bool> _handleLoginResponse(ApiResponse<UserModel> response,
      {bool isLogin = true}) async {
    if (response.r != null) {
      user.value = response.r;
      if (isLogin) {
        await SharedPref.I.setJwtToken(response.token ?? '');
        DioClient.I.refreshToken();
      }
      isLoggin.value = true;
      TrackUtil.updateUserInfo();
      return true;
    } else {
      isLoggin.value = false;
      return false;
    }
  }
}
