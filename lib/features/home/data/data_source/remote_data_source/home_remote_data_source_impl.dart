import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taska/core/database/database.dart';
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
}
