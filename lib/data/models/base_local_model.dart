import 'package:isar/isar.dart';

class BaseLocalModel {
  Id id = Isar.autoIncrement;
  BaseLocalModel({this.id = Isar.autoIncrement});
}
