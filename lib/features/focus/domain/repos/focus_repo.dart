import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:app_usage/app_usage.dart';

abstract class FocusRepo {
  Future<Either<Failure, void>> addTimeForToday(int seconds);
  Future<Either<Failure, int>> getTimeForToday();
  Future<Either<Failure, List<AppUsageInfo>>> getAppUsageInfo();
}
