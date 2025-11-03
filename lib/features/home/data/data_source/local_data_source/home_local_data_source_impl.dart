import 'package:hive_flutter/hive_flutter.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/features/home/data/data_source/local_data_source/home_local_data_source.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/entities/task.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<void> createCategory(CategoryData categoryData) async {
    var box = Hive.box<CategoryData>(kCategoryBox);
    await box.add(categoryData);
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    var box = Hive.box<TaskEntity>(kTaskBox);
    await box.add(task);
  }

  @override
  List<CategoryData> getAllCategories() {
    var box = Hive.box<CategoryData>(kCategoryBox);
    return box.values.toList();
  }
}
