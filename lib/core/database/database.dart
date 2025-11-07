import 'package:hive/hive.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/entities/task.dart';

const kTaskBox = 'tasks_box';
const kCategoryBox = 'categories_box';
Future<void> setupDatabase() async {
  Hive.registerAdapter(CategoryEntityAdapter());
  Hive.registerAdapter(TaskEntityAdapter());
  await Hive.openBox<TaskEntity>(kTaskBox);
  await Hive.openBox<CategoryEntity>(kCategoryBox);
}

Future<void> clearDatabase() async {
  await Hive.box<TaskEntity>(kTaskBox).clear();
  await Hive.box<CategoryEntity>(kCategoryBox).clear();
}
