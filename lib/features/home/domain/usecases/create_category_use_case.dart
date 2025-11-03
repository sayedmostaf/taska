import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/repos/home_repo.dart';

class CreateCategoryUseCase extends UseCase<void, CategoryEntity> {
  final HomeRepo homeRepo;
  CreateCategoryUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, void>> execute([CategoryEntity? inputs]) async {
    return await homeRepo.createCategory(inputs!);
  }
}
