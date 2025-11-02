import 'package:flutter/widgets.dart';

class CategoryData {
  final String name, id;
  final IconData iconData;
  final Color color;
  CategoryData(this.id,{
    required this.name,
    required this.iconData,
    required this.color,
  });
}
