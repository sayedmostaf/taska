sealed class ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedInitial
    extends ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedSuccess
    extends ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedFailure
    extends ChangeTasksToUncompletedState {
  final String errMessage;

  ChangeTasksToUncompletedFailure({required this.errMessage});
}
