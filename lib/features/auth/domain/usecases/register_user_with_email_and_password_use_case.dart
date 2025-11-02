import 'package:dartz/dartz.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/features/auth/domain/entities/user.dart';
import 'package:taska/features/auth/domain/repos/auth_repo.dart';

class RegisterUserWithEmailAndPasswordUseCase extends UseCase<void, UserData> {
  final AuthRepo authRepo;

  RegisterUserWithEmailAndPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([UserData? inputs]) async {
    return await authRepo.registerUserWithEmailAndPassword(inputs!);
  }
}
