import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/usecases/change_tasks_to_uncompleted_usecase.dart';
import 'package:taska/features/home/domain/usecases/delete_old_tasks_use_case.dart';
import 'package:taska/features/home/presentation/manager/change_tasks_to_un_completed_cubit/change_tasks_to_un_completed_state.dart';
import 'package:taska/features/index/presentation/manager/change_task_status_cubit/change_task_status_state.dart';

class ChangeTasksToUncompletedCubit
    extends Cubit<ChangeTasksToUncompletedState> {
  ChangeTasksToUncompletedCubit(
    this.changeTasksToUncompletedUseCase,
    this.deleteOldTasksUseCase,
  ) : super(ChangeTasksToUncompletedInitial());
  final ChangeTasksToUncompletedUseCase changeTasksToUncompletedUseCase;
  final DeleteOldTasksUseCase deleteOldTasksUseCase;
  Future<void> changeTasksToUncompleted() async {
    emit(ChangeTasksToUncompletedInitial());
    await changeTasksToUncompletedUseCase.execute();
    var res = await changeTasksToUncompletedUseCase.execute();
    res.fold(
      (failure) =>
          emit(ChangeTasksToUncompletedFailure(errMessage: failure.message)),
      (success) => emit(ChangeTasksToUncompletedSuccess()),
    );
  }
}
