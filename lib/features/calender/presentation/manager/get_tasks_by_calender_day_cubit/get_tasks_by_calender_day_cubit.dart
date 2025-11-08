import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/calender/presentation/manager/get_tasks_by_calender_day_cubit/get_tasks_by_calender_day_state.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/usecases/get_task_by_day_use_case.dart';

class GetTasksByCalendarDayCubit extends Cubit<GetTasksByCalendarDayState> {
  GetTasksByCalendarDayCubit(this.getTaskByDayUseCase)
    : super(GetTasksByCalendarDayInitial());
  final GetTaskByDayUseCase getTaskByDayUseCase;
  DateTime? storedDay;
  late bool storedIsCompleted;
  Future<void> getTasksByDay({
    DateTime? day,
    required bool? isCompleted,
  }) async {
    emit(GetTasksByCalendarDayLoading());
    if (day != null) {
      storedDay = day;
    }
    if (isCompleted != null) {
      storedIsCompleted = isCompleted;
    }
    var result = await getTaskByDayUseCase.execute(day ?? storedDay);
    result.fold(
      (failure) {
        return emit(GetTasksByCalendarDayFailure(errMessage: failure.message));
      },
      (tasks) async {
        (List<TaskEntity>, List<TaskEntity>) tasksSplitted = splitTasks(tasks);
        await Future.delayed(const Duration(milliseconds: 200));
        return emit(
          GetTasksByCalendarDaySuccess(
            tasks: storedIsCompleted ? tasksSplitted.$2 : tasksSplitted.$1,
          ),
        );
      },
    );
  }

  (List<TaskEntity> uncompleted, List<TaskEntity> completed) splitTasks(
    List<TaskEntity> tasks,
  ) {
    List<TaskEntity> completed = [];
    List<TaskEntity> uncompleted = [];
    for (var task in tasks) {
      if (task.status == 'completed') {
        completed.add(task);
      } else {
        uncompleted.add(task);
      }
    }
    return (uncompleted, completed);
  }
}
