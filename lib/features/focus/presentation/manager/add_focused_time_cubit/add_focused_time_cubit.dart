import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/focus/domain/usecases/add_time_for_today_use_case.dart';
import 'package:taska/features/focus/presentation/manager/add_focused_time_cubit/add_focused_time_state.dart';

class AddFocusedTimeCubit extends Cubit<AddFocusedTimeState> {
  AddFocusedTimeCubit(this.addTimeForTodayUseCase)
    : super(AddFocusedTimeInitial());
  final AddTimeForTodayUseCase addTimeForTodayUseCase;

  Future<void> addFocusedTime(int seconds) async {
    emit(AddFocusedTimeLoading());
    var result = await addTimeForTodayUseCase.execute(seconds);
    result.fold(
      (failure) {
        return emit(AddFocusedTimeFailure(errMessage: failure.message));
      },
      (success) {
        return emit(AddFocusedTimeSuccess());
      },
    );
  }
}
