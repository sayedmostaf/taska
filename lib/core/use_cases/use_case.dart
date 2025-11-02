import 'package:dartz/dartz.dart';
import 'package:taska/core/utils/failures.dart';

abstract class UseCase<T, Inputs> {
  Future<Either<Failure, T>> execute([Inputs inputs]);
}
