import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/repos/index_repo.dart';

class EditTaskUseCase extends UseCase<void, (TaskEntity, TaskEntity)> {
  final IndexRepo indexRepo;
  EditTaskUseCase({required this.indexRepo});
  @override
  Future<Either<Failure, void>> execute([
    (TaskEntity, TaskEntity)? inputs,
  ]) async {
    return await indexRepo.editTask(oldTask: inputs!.$1, newTask: inputs.$2);
  }
}
