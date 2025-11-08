import 'package:app_usage/app_usage.dart';

sealed class GetAppsUsageListState {}

final class GetAppsUsageListInitial extends GetAppsUsageListState {}

final class GetAppsUsageListLoading extends GetAppsUsageListState {}

final class GetAppsUsageListFailure extends GetAppsUsageListState {
  final String errMessage;

  GetAppsUsageListFailure({required this.errMessage});
}

final class GetAppsUsageListSuccess extends GetAppsUsageListState {
  final List<AppUsageInfo> appInfos;

  GetAppsUsageListSuccess({required this.appInfos});
}
