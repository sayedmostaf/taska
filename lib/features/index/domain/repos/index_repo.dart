import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/features/home/domain/entities/task.dart';

abstract class IndexRepo {
  Future<Either<Failure, (List<TaskEntity>, List<TaskEntity>)>> getTasksByDay(
    DateTime day,
  );
  Future<Either<Failure, List<TaskEntity>>> filterTasksByNameOrPriority(
    bool byName,
    bool byPriority,
    List<TaskEntity> tasks,
  );
  Future<Either<Failure, List<TaskEntity>>> searchTask(
    String searchText,
    List<TaskEntity> tasks,
  );
}
