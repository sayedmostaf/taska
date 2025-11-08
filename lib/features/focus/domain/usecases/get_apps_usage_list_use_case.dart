import 'package:app_usage/app_usage.dart';
import 'package:dartz/dartz.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/use_cases/use_case.dart';
import 'package:taska/features/focus/domain/repos/focus_repo.dart';

class GetAppsUsageListUseCase extends UseCase<List<AppUsageInfo>, void> {
  final FocusRepo focusRepo;
  GetAppsUsageListUseCase({required this.focusRepo});
  @override
  Future<Either<Failure, List<AppUsageInfo>>> execute([void inputs]) async {
    return await focusRepo.getAppUsageInfo();
  }
}
