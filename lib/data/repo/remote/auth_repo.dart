import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:flutter_base_project/data/data_source/dio_client.dart';
import 'package:flutter_base_project/data/domain/end_points.dart';
import 'package:flutter_base_project/data/models/user_model.dart';
import 'package:flutter_base_project/data/response/exports.dart';

import 'remote_repo.dart';

class AuthRepo extends RemoteRepo<UserModel> {
  static const String tag = 'AuthRepo';
  AuthRepo()
      : super(DioClient.I,
            endPoint: EndPoints.REMOTE_USER, constructor: UserModel.fromMap);

  Future<ApiResponse<UserModel>> login() async {
    try {
      String uri = EndPoints.LOGIN;
      final response = await dio.post(uri, data: {
        "device_id": DeviceUtil.deviceId,
        "device_name": DeviceUtil.isAndroid
            ? DeviceUtil.androidInfo!.model
            : DeviceUtil.iosInfo!.model,
        "platform": DeviceUtil.isAndroid ? 'android' : 'ios',
        "app_version": DeviceUtil.appVersion,
        "os_version": DeviceUtil.isAndroid
            ? DeviceUtil.androidInfo!.version.release
            : DeviceUtil.iosInfo!.systemVersion,
      });
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(UserModel.fromMap(data['data']),
            token: data['token']);
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<ApiResponse<UserModel>> getUserInfo() async {
    try {
      String uri = EndPoints.GET_USER_INFO;
      final response = await dio.post(uri);
      if (HttpUtil.validateResponse(response)) {
        final data = response.data as Map<String, dynamic>;
        return ApiResponse.success(UserModel.fromMap(data));
      } else {
        return ApiResponse.error(response.data);
      }
    } catch (e) {
      return ApiResponse.error(e);
    }
  }
}
