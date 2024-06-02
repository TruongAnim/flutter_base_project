import 'dart:convert';

import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:isar/isar.dart';
import 'base_model.dart';

part 'product_model.g.dart';

@collection
class ProductModel extends BaseModel {
  String? name;
  List<String>? ingredients;
  ProductModel({
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
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : Isar.autoIncrement,
      name: mapToString(map['name']),
      ingredients: map['ingredients'] != null
          ? List<String>.from(map['ingredients'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
