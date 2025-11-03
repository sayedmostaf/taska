import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/home/domain/usecases/create_task_use_case.dart';
import 'package:taska/features/home/presentation/manager/create_task_cubit/create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase createTaskUseCase;
  CreateTaskCubit(this.createTaskUseCase) : super(CreateTaskInitial());
  Future<void> createTask(TaskEntity taskEntity) async {
    emit(CreateTaskLoading());
    var result = await createTaskUseCase.execute(taskEntity);
    result.fold(
      (failure) {
        emit(CreateTaskFailure(errMessage: failure.message));
      },
      (taskData) {
        emit(CreateTaskSuccess());
      },
    );
  }
}
