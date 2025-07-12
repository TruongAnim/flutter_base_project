enum MappingType {
  localEndPoint,
  remoteEndPoint,
  constructor,
  isarCollection,
}

class Mapping {
  Mapping._();
  static final Mapping _instance = Mapping._();
  static Mapping get instance => _instance;
  static Mapping get I => _instance;

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
