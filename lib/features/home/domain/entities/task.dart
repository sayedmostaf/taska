import 'package:hive_flutter/hive_flutter.dart';
import 'package:taska/features/home/domain/entities/category.dart';
part 'task.g.dart';


@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String status;
  @HiveField(4)
  final CategoryData category;
  @HiveField(5)
  final int priority;
  @HiveField(6)
  final DateTime utcTime;
  TaskEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.category,
    required this.priority,
    required this.utcTime,
  });
}
