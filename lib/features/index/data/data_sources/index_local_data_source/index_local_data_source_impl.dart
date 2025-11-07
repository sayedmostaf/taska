import 'package:hive_flutter/adapters.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/data/data_sources/index_local_data_source/index_local_data_source.dart';

class IndexLocalDataSourceImpl implements IndexLocalDataSource {
  @override
  List<TaskEntity> getTasksByDay(DateTime day) {
    var box = Hive.box<TaskEntity>(kTaskBox);
    List<TaskEntity> tasks = [];
    DateTime endDate = day.add(Duration(days: 1));
    for (var taskEntity in box.values.toList()) {
      if ((taskEntity.utcTime.isAtSameMomentAs(day) ||
              taskEntity.utcTime.isAfter(day)) &&
          taskEntity.utcTime.isBefore(endDate)) {
        tasks.add(taskEntity);
      }
    }
    return tasks;
  }

  @override
  Future<void> changeTaskStatus(String status, String taskId) async {
    var box = Hive.box<TaskEntity>(kTaskBox);
    var taskIndex = box.values.toList().indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      TaskEntity taskToUpdate = box.getAt(taskIndex)!;
      TaskEntity newTask = TaskEntity(
        id: taskToUpdate.id,
        name: taskToUpdate.name,
        description: taskToUpdate.description,
        status: status,
        category: taskToUpdate.category,
        priority: taskToUpdate.priority,
        utcTime: taskToUpdate.utcTime,
      );
      await box.putAt(taskIndex, newTask);
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    var box = Hive.box<TaskEntity>(kTaskBox);
    int taskIndex = box.values.toList().indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      await box.deleteAt(taskIndex);
    }
  }

  @override
  Future<void> editTask({
    required TaskEntity oldTask,
    required TaskEntity newTask,
  }) async {
    var box = Hive.box<TaskEntity>(kTaskBox);
    var taskIndex = box.values.toList().indexWhere(
      (task) => task.id == oldTask.id,
    );
    if (taskIndex != -1) {
      await box.putAt(taskIndex, newTask);
    }
  }
}
