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
      if (taskEntity.utcTime.isAfter(day) &&
          taskEntity.utcTime.isBefore(endDate)) {
        tasks.add(taskEntity);
      }
    }
    return tasks;
  }
}
