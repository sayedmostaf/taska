import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/features/home/domain/entities/category.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryData>>> getAllCategories();
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> createCategory(CategoryData categoryData);
}
