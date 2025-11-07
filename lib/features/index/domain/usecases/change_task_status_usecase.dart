import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/index/domain/repos/index_repo.dart';

class ChangeTaskStatusUseCase extends UseCase<void, (String, String)> {
  final IndexRepo indexRepo;
  ChangeTaskStatusUseCase(this.indexRepo);

  @override
  Future<Either<Failure, void>> execute([(String, String)? inputs]) async {
    return indexRepo.changeTaskStatus(status: inputs!.$1, taskId: inputs.$2);
  }
}
