import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/repos/index_repo.dart';

class GetTaskByDayUseCase
    extends UseCase<List<TaskEntity>, DateTime> {
  final IndexRepo indexRepo;
  GetTaskByDayUseCase({required this.indexRepo});
  @override
  Future<Either<Failure, List<TaskEntity>>> execute([
    DateTime? inputs,
  ]) async {
    return await indexRepo.getTasksByDay(inputs!);
  }
}
