import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/index/domain/usecases/change_task_status_usecase.dart';
import 'package:taska/features/index/presentation/manager/change_task_status_cubit/change_task_status_state.dart';

class ChangeTaskStatusCubit extends Cubit<ChangeTaskStatusState> {
  final ChangeTaskStatusUseCase changeTaskStatusUseCase;

  ChangeTaskStatusCubit(this.changeTaskStatusUseCase)
    : super(ChangeTaskStatusInitial());
  Future<void> changeTaskStatus(String status, String taskId) async {
    emit(ChangeTaskStatusLoading());
    var result = await changeTaskStatusUseCase.execute((status, taskId));
    result.fold(
      (failure) {
        return emit(ChangeTaskStatusFailure(errMessage: failure.message));
      },
      (r) {
        return emit(ChangeTaskStatusSuccess());
      },
    );
  }
}
