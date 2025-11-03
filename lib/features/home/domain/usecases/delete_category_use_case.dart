import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/home/domain/repos/home_repo.dart';

class DeleteCategoryUseCase extends UseCase<void, String> {
  final HomeRepo homeRepo;
  DeleteCategoryUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, void>> execute([String? inputs]) async {
    return await homeRepo.deleteCategory(inputs!);
  }
}
