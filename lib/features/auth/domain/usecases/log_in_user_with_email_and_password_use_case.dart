import 'package:dartz/dartz.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/core/utils/failures.dart';
import 'package:taska/features/auth/domain/entities/user.dart';
import 'package:taska/features/auth/domain/repos/auth_repo.dart';

class LogInUserWithEmailAndPasswordUseCase extends UseCase<void, User> {
  final AuthRepo authRepo;
  LogInUserWithEmailAndPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([User? inputs]) async {
    return await authRepo.logInUserWithEmailAndPassword(inputs!);
  }
}
