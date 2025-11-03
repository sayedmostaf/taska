import 'package:hive_flutter/hive_flutter.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/features/home/data/data_source/local_data_source/home_local_data_source.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/entities/task.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<void> createCategory(CategoryEntity categoryData) async {
    var box = Hive.box<CategoryEntity>(kCategoryBox);
    await box.add(categoryData);
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    var box = Hive.box<TaskEntity>(kTaskBox);
    await box.add(task);
  }

  @override
  List<CategoryEntity> getAllCategories() {
    var box = Hive.box<CategoryEntity>(kCategoryBox);
    return box.values.toList();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    var box = Hive.box<CategoryEntity>(kCategoryBox);
    int categoryIndex = box.values.toList().indexWhere(
      (category) => category.id == categoryId,
    );
    if (categoryIndex != -1) {
      await box.deleteAt(categoryIndex);
    }
  }
}
