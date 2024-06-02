import 'package:flutter_base_project/core/helper/exports.dart';

enum MappingType {
  localEndPoint,
  remoteEndPoint,
  constructor,
  isarCollection,
}

mixin Mapping {
  final Map<Type, Map<MappingType, dynamic>> _mapping = {};

  void registerMapping<T>(MappingType type, dynamic data) {
    Map<MappingType, dynamic>? value = _mapping[T];
    value ??= {};
    value[type] = data;
    _mapping[T] = value;
  }

  dynamic getMapping<T>(MappingType type) {
    if (_mapping.containsKey(T)) {
      return _mapping[T]![type];
    } else {
      throw Exception('getMapping for $T (type $type) not found.');
    }
  }
}
