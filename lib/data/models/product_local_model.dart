import 'dart:convert';

import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:isar/isar.dart';
import 'base_local_model.dart';

part 'product_local_model.g.dart';

@collection
class ProductLocalModel extends BaseLocalModel {
  String? name;
  List<String>? ingredients;
  ProductLocalModel({
    super.id = Isar.autoIncrement,
    this.name,
    this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ingredients': ingredients,
    };
  }

  @override
  factory ProductLocalModel.fromMap(Map<String, dynamic> map) {
    return ProductLocalModel(
      id: map['id'] != null ? map['id'] as int : Isar.autoIncrement,
      name: mapToString(map['name']),
      ingredients: map['ingredients'] != null
          ? List<String>.from(map['ingredients'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductLocalModel.fromJson(String source) =>
      ProductLocalModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
