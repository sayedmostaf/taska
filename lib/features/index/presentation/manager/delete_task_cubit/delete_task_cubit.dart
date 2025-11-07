import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/index/domain/usecases/delete_task_usecase.dart';
import 'package:taska/features/index/presentation/manager/delete_task_cubit/delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit(this.deleteTaskUseCase) : super(DeleteTaskInitial());
  final DeleteTaskUseCase deleteTaskUseCase;
  Future<void> deleteTask(String taskId) async {
    emit(DeleteTaskLoading());
    var result = await deleteTaskUseCase.execute(taskId);
    result.fold(
      (failure) => emit(DeleteTaskFailure(errMessage: failure.message)),
      (r) => emit(DeleteTaskSuccess()),
    );
  }
}
