import 'package:drift/drift.dart';
import 'package:todoapp/core/database/app_database.dart';

import '../../domain/entities/category.dart' as entity;

class CategoryModel {
  final String id;
  final String name;
  final String color;
  final String icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'color': color, 'icon': icon};
  }

  entity.Category toEntity() {
    return entity.Category(id: id, name: name, color: color, icon: icon);
  }

  factory CategoryModel.fromEntity(entity.Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      color: category.color,
      icon: category.icon,
    );
  }

  factory CategoryModel.fromDrift(Category driftCategory) {
    return CategoryModel(
      id: driftCategory.id,
      name: driftCategory.name,
      color: driftCategory.color,
      icon: driftCategory.icon,
    );
  }

  CategoriesCompanion toDriftCompanion() {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      icon: Value(icon),
    );
  }
}
