import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/usecases/log_in_user_with_google_use_case.dart';
import 'package:taska/features/auth/presentation/manager/log_in_user_with_google_cubit/log_in_user_with_google_state.dart';

class LogInUserWithGoogleCubit extends Cubit<LogInUserWithGoogleState> {
  final LogInUserWithGoogleUseCase logInUserWithGoogleUseCase;
  LogInUserWithGoogleCubit(this.logInUserWithGoogleUseCase)
    : super(LogInUserWithGoogleInitial());
  Future<void> logInUserWithGoogle() async {
    emit(LogInUserWithGoogleLoading());
    var result = await logInUserWithGoogleUseCase.execute();
    result.fold(
      (failure) =>
          emit(LogInUserWithGoogleFailure(errMessage: failure.message)),
      (r) => emit(LogInUserWithGoogleSuccess()),
    );
  }
}
