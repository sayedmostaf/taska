import 'package:taska/features/home/domain/entities/task.dart';

sealed class GetTaskByDayState {}

final class GetTasksByDayInitial extends GetTaskByDayState {}

final class GetTasksByDayLoading extends GetTaskByDayState {}

final class GetTasksByDayFailure extends GetTaskByDayState {
  final String errMessage;

  GetTasksByDayFailure({required this.errMessage});
}

final class GetTasksByDaySuccess extends GetTaskByDayState {
  final List<TaskEntity> uncompleted;
  final List<TaskEntity> completed;

  GetTasksByDaySuccess({required this.uncompleted, required this.completed});
}
