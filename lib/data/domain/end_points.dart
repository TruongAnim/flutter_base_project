// ignore_for_file: constant_identifier_names

mixin EndPoints {
  // static const String BASE_URL = 'http://10.0.2.2:3001/api/';
  // static const String BASE_URL = 'https://base.stream.io.vn/api/';
  static const String BASE_URL = 'https://dramatv.dmobin.studio/api/';

  static const String REMOTE_POST = '${BASE_URL}post';
  static const String REMOTE_FILM = '${BASE_URL}film_for_you';

  static const String LOCAL_PATH = 'assets/data/';
  static const String LOCAL_PRODUCT = '${LOCAL_PATH}products.json';
}
