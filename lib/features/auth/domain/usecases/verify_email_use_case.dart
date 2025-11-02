import 'package:dartz/dartz.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/core/utils/failures.dart';
import 'package:taska/features/auth/domain/repos/auth_repo.dart';

class VerifyEmailUseCase extends UseCase<void, String> {
  final AuthRepo authRepo;

  VerifyEmailUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([String? inputs]) async {
    return await authRepo.verifyEmail(inputs!);
  }
}
