import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/index/domain/usecases/edit_task_usecase.dart';
import 'package:taska/features/index/presentation/manager/edit_task_cubit/edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit(this.editTaskUseCase) : super(EditTaskInitial());
  final EditTaskUseCase editTaskUseCase;
  Future<void> editTask(TaskEntity oldTask, TaskEntity newTask) async {
    emit(EditTaskLoading());
    var result = await editTaskUseCase.execute((oldTask, newTask));
    result.fold(
      (failure) => emit(EditTaskFailure(errMessage: failure.message)),
      (r) => emit(EditTaskSuccess()),
    );
  }
}
