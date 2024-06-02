import 'package:isar/isar.dart';

class BaseModel {
  Id id = Isar.autoIncrement;
  BaseModel({this.id = Isar.autoIncrement});
}
