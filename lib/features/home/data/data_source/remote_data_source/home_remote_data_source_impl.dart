import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/core/notifications/local_notification.dart';
import 'package:taska/core/utils/functions/save_data.dart';
import 'package:taska/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:taska/features/home/data/models/category_model/category_model.dart';
import 'package:taska/features/home/data/models/task_model/task_model.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/entities/task.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  HomeRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });
  @override
  Future<void> createCategory(CategoryEntity categoryData) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .doc(categoryData.id)
        .set(CategoryModel.fromEntity(categoryData).toJson());
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(task.id)
        .set(TaskModel.fromEntity(task).toJson());
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .get();
    List<CategoryEntity> categories = [];
    _parseCategories(querySnapshot, categories);
    await saveCategories(categories, kCategoryBox);
    return categories;
  }

  void _parseCategories(
    QuerySnapshot<Object?> querySnapshot,
    List<CategoryEntity> categories,
  ) {
    for (var category in querySnapshot.docs) {
      categories.add(
        CategoryModel.fromJson(category.data() as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  @override
  Future<void> changeTasksToUncompleted() async {
    await addNewUnStoredTasksToDB();
    var box = Hive.box<TaskEntity>(kTaskBox);
    List<TaskEntity> tasksStored = box.values.toList();
    List<TaskEntity> tasksBeforeToday = tasksStored
        .where(
          (task) => task.utcTime.isBefore(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              0,
              0,
              0,
            ),
          ),
        )
        .toList();
    for (TaskEntity task in tasksBeforeToday) {
      if (task.status == 'pending') {
        updateTaskStatus(task, tasksStored, box);
      }
    }
  }

  Future<void> updateTaskStatus(
    TaskEntity task,
    List<TaskEntity> tasksStored,
    var box,
  ) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(task.id);
    await taskRef.update({'status': 'uncompleted'});
    var taskIndex = tasksStored.indexWhere((task) => task.id == task.id);
    if (taskIndex != -1) {
      TaskEntity newTask = TaskEntity(
        id: task.id,
        name: task.name,
        description: task.description,
        status: 'uncompleted',
        category: task.category,
        priority: task.priority,
        utcTime: task.utcTime,
      );
      await box.putAt(taskIndex, newTask);
    }
  }

  Future<void> addNewUnStoredTasksToDB() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where(
          'utc_time',
          isGreaterThanOrEqualTo: DateTime(
            DateTime.now().year,
            DateTime.now().month - 2,
            DateTime.now().day,
            0,
            0,
            0,
          ).toUtc().toIso8601String(),
        )
        .where(
          'utc_time',
          isLessThan: DateTime(
            DateTime.now().year,
            DateTime.now().month + 2,
            DateTime.now().day,
            0,
            0,
            0,
          ).toUtc().toIso8601String(),
        )
        .get();
    List<TaskEntity> tasksRetrieved = parseRetrievedTasks(querySnapshot);
    var box = Hive.box<TaskEntity>(kTaskBox);
    List<TaskEntity> tasksStored = box.values.toList();
    List<TaskEntity> newStoredTasks = findNewTasks(tasksRetrieved, tasksStored);
    await saveTasks(newStoredTasks, kTaskBox);
  }

  List<TaskEntity> parseRetrievedTasks(QuerySnapshot<Object?> querySnapshot) {
    List<TaskEntity> tasksRetrieved = [];
    for (var task in querySnapshot.docs) {
      tasksRetrieved.add(
        TaskModel.fromJson(task.data() as Map<String, dynamic>),
      );
    }
    return tasksRetrieved;
  }

  List<TaskEntity> findNewTasks(
    List<TaskEntity> tasksRetrieved,
    List<TaskEntity> tasksStored,
  ) {
    Set<String> storedTaskIds = Set<String>.from(
      tasksStored.map((task) => task.id),
    );
    List<TaskEntity> newTasks = tasksRetrieved
        .where((task) => !storedTaskIds.contains(task.id))
        .toList();
    for (var task in newTasks) {
      if (task.status == 'pending' && task.utcTime.isAfter(DateTime.now())) {
        LocalNotification.scheduleNotifications(
          id: task.id,
          title: task.name,
          body: task.description,
          scheduledDate: task.utcTime,
        );
      }
    }
    return newTasks;
  }

  @override
  Future<void> deleteOldTasks() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where(
          'utc_time',
          isLessThanOrEqualTo: DateTime(
            DateTime.now().year,
            DateTime.now().month - 2,
            DateTime.now().day - 1,
            0,
            0,
            0,
          ).toUtc().toIso8601String(),
        )
        .get();
    List<TaskEntity> tasksRetrieved = parseRetrievedTasks(querySnapshot);
    await deleteTasks(tasksRetrieved);
  }

  Future<void> deleteTasks(List<TaskEntity> tasks) async {
    for (TaskEntity targetTasks in tasks) {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(targetTasks.id)
          .delete();
      var box = Hive.box<TaskEntity>(kTaskBox);
      int taskIndex = box.values.toList().indexWhere(
        (task) => task.id == targetTasks.id,
      );
      if (taskIndex != -1) {
        await box.deleteAt(taskIndex);
      }
    }
  }
}
