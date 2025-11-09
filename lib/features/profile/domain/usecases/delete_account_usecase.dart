import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/profile/domain/repos/profile_repo.dart';

class DeleteAccountUseCase extends UseCase<void, String?> {
  final ProfileRepo profileRepo;
  DeleteAccountUseCase({required this.profileRepo});
  @override
  Future<Either<Failure, void>> execute([String? inputs]) async {
    return await profileRepo.deleteAccount(inputs);
  }
}
