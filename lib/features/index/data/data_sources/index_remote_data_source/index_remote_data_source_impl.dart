import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/core/utils/functions/save_data.dart';
import 'package:taska/features/home/data/models/task_model/task_model.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/data/data_sources/index_remote_data_source/index_remote_data_source.dart';

class IndexRemoteDataSourceImpl implements IndexRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  IndexRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });
  @override
  Future<List<TaskEntity>> getTasksByDay(DateTime day) async {
    DateTime endDate = day.add(Duration(days: 1));

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where(
          'utc_time',
          isGreaterThanOrEqualTo: day.toUtc().toIso8601String(),
        )
        .where('utc_time', isLessThan: endDate.toUtc().toIso8601String())
        .get();
    List<TaskEntity> tasks = [];
    _parseTasks(querySnapshot, tasks);
    await saveTasks(tasks, kTaskBox);
    return tasks;
  }

  void _parseTasks(
    QuerySnapshot<Object?> querySnapshot,
    List<TaskEntity> tasks,
  ) {
    for (var task in querySnapshot.docs) {
      tasks.add(TaskModel.fromJson(task.data() as Map<String, dynamic>));
    }
  }

  @override
  Future<void> changeTaskStatus(String status, String taskId) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId);
    await taskRef.update({'status': status});
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  @override
  Future<void> editTask({
    required TaskEntity oldTask,
    required TaskEntity newTask,
  }) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(oldTask.id);
    await taskRef.update(TaskModel.fromEntity(newTask).toJson());
  }
}
