import 'package:taska/features/home/domain/entities/category.dart';

class Task {
  final String id, name, description, status;
  final CategoryData category;
  final int priority;
  final DateTime utcTime;
  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.category,
    required this.priority,
    required this.utcTime,
  });
}
