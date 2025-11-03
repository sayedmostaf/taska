import 'package:taska/features/home/domain/entities/category.dart';

class CategoryModel extends CategoryData {
  final String categoryId;
  final String name;
  final int icon;
  final String colorHex;
  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.colorHex,
  }) : super(id: categoryId, name: name, iconData: icon, color: colorHex);
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['id'],
      name: json['name'],
      icon: json['icon'],
      colorHex: json['color'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': categoryId, 'name': name, 'icon': icon, 'color': colorHex};
  }

  factory CategoryModel.fromEntity(CategoryData categoryData) {
    return CategoryModel(
      categoryId: categoryData.id,
      name: categoryData.name,
      icon: categoryData.iconData,
      colorHex: categoryData.color,
    );
  }
}
