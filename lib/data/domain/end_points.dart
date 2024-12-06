// ignore_for_file: constant_identifier_names

import 'package:flutter_base_project/constants/app_const.dart';

mixin EndPoints {
  // static const String BASE_URL = 'http://10.0.2.2:3001/api/';
  // static const String BASE_URL = 'https://base.stream.io.vn/api/';
  static const String BASE_URL = AppConst.buildType == BuildType.product
      ? 'https://reelbox.me/'
      : 'https://dev.reelbox.me/';

  static const String REMOTE_USER = '${BASE_URL}user';
  static const String LOGIN = '${BASE_URL}auth/user/login';
  static const String GET_USER_INFO = '${BASE_URL}api/user/get_info';
  static const String REMOTE_POST = '${BASE_URL}post';
  static const String REMOTE_FILM = '${BASE_URL}api/list_films';

  static const String LOCAL_PATH = 'assets/data/';
  static const String LOCAL_PRODUCT = '${LOCAL_PATH}products.json';
}
