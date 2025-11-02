import 'package:dartz/dartz.dart';
import 'package:taska/core/utils/failures.dart';
import 'package:taska/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> registerUserWithEmailAndPassword(User user);
  Future<Either<Failure, void>> logInUserWithEmailAndPassword(User user);
  Future<Either<Failure, void>> verifyEmail(String email);
}
