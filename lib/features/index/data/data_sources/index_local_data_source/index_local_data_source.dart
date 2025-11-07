import 'package:taska/features/home/domain/entities/task.dart';

abstract class IndexLocalDataSource {
  List<TaskEntity> getTasksByDay(DateTime day);
  Future<void> changeTaskStatus(String status, String taskId);
  Future<void> editTask({
    required TaskEntity oldTask,
    required TaskEntity newTask,
  });
  Future<void> deleteTask(String taskId);
}
