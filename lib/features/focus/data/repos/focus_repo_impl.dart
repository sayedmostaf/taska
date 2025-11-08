import 'package:app_usage/app_usage.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/focus/data/data_source/focus_local_remote_data_source/focus_local_data_source.dart';
import 'package:taska/features/focus/data/data_source/focus_remote_data_source/focus_remote_data_source.dart';
import 'package:taska/features/focus/domain/repos/focus_repo.dart';

class FocusRepoImpl extends FocusRepo {
  final FocusRemoteDataSource focusRemoteDataSource;
  final FocusLocalDataSource focusLocalDataSource;

  FocusRepoImpl({
    required this.focusRemoteDataSource,
    required this.focusLocalDataSource,
  });
  @override
  Future<Either<Failure, void>> addTimeForToday(int seconds) async {
    try {
      await focusRemoteDataSource.addTimeForToday(seconds);
      await focusLocalDataSource.addTimeForToday(seconds);
      return right(null);
    } catch (e) {
      return left(Failure(message: StringsManager.operationNotAllowed.tr()));
    }
  }

  @override
  Future<Either<Failure, int>> getTimeForToday() async {
    try {
      int? localSeconds = focusLocalDataSource.getTimeForToday();
      if (localSeconds != null) {
        return right(localSeconds);
      }
      int remoteSeconds = await focusRemoteDataSource.getTimeForToday();
      return right(remoteSeconds);
    } catch (e) {
      return left(Failure(message: StringsManager.operationNotAllowed.tr()));
    }
  }

  @override
  Future<Either<Failure, List<AppUsageInfo>>> getAppUsageInfo() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        0,
        1,
        0,
      );
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      List<AppUsageInfo> appsResult = filterAppUsageList(infoList);
      return right(appsResult);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  List<AppUsageInfo> filterAppUsageList(List<AppUsageInfo> infoList) {
    List<AppUsageInfo> appsResult = [];
    for (var app in infoList) {
      if (app.usage.inMinutes > 5) {
        appsResult.add(app);
      }
    }
    return appsResult;
  }
}
