import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';

abstract class FocusRepo {
  Future<Either<Failure, void>> addTimeForToday(int seconds);
  Future<Either<Failure, int>> getTimeForToday();
}
