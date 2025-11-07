import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/usecases/get_task_by_day_use_case.dart';
import 'package:taska/features/index/presentation/manager/get_task_by_day_cubit/get_task_by_day_state.dart';

class GetTasksByDayCubit extends Cubit<GetTaskByDayState> {
  GetTasksByDayCubit(this.getTaskByDayUseCase) : super(GetTasksByDayInitial());
  final GetTaskByDayUseCase getTaskByDayUseCase;
  DateTime? sortedDate;
  Future<void> getTaskByDay(DateTime? day) async {
    emit(GetTasksByDayLoading());
    if (day != null) {
      sortedDate = day;
    }
    var result = await getTaskByDayUseCase.execute(day ?? sortedDate);
    result.fold(
      (failure) {
        return emit(GetTasksByDayFailure(errMessage: failure.message));
      },
      (tasks) {
        (List<TaskEntity>, List<TaskEntity>) tasksSplitted = splitTasks(tasks);
        return emit(
          GetTasksByDaySuccess(
            uncompleted: tasksSplitted.$1,
            completed: tasksSplitted.$2,
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
