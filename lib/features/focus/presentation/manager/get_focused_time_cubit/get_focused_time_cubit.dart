import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/focus/domain/usecases/get_focused_time_use_case.dart';
import 'package:taska/features/focus/presentation/manager/get_focused_time_cubit/get_focused_time_state.dart';

class GetFocusedTimeCubit extends Cubit<GetFocusedTimeState> {
  GetFocusedTimeCubit(this.getFocusedTimeUseCase)
    : super(GetFocusedTimeInitial());
  final GetFocusedTimeUseCase getFocusedTimeUseCase;

  Future<void> getFocusedTime() async {
    emit(GetFocusedTimeLoading());
    var result = await getFocusedTimeUseCase.execute();
    result.fold(
      (failure) {
        return emit(GetFocusedTimeFailure(errMessage: failure.message));
      },
      (seconds) {
        return emit(GetFocusedTimeSuccess(seconds: seconds));
      },
    );
  }
}
