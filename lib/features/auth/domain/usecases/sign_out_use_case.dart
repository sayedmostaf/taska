import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/auth/domain/repos/auth_repo.dart';

class SignOutUseCase extends UseCase<void, void> {
  final AuthRepo authRepo;
  SignOutUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([void inputs]) async {
    return await authRepo.signOut();
  }
}
