import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/repos/index_repo.dart';

class FilterTaskByNameOrPriorityUseCase
    extends
        UseCase<
          List<TaskEntity>,
          (bool byName, bool byPriority, List<TaskEntity> tasks)
        > {
  final IndexRepo indexRepo;
  FilterTaskByNameOrPriorityUseCase({required this.indexRepo});
  @override
  Future<Either<Failure, List<TaskEntity>>> execute([
    (bool, bool, List<TaskEntity>)? inputs,
  ]) async {
    return await indexRepo.filterTasksByNameOrPriority(
      inputs!.$1,
      inputs!.$2,
      inputs!.$3,
    );
  }
}
