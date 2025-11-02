import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/entities/user.dart';
import 'package:taska/features/auth/domain/usecases/log_in_user_with_email_and_password_use_case.dart';
import 'package:taska/features/auth/presentation/manager/login_user_with_email_and_password_cubit/login_user_with_email_and_password_state.dart';

class LoginUserWithEmailAndPasswordCubit
    extends Cubit<LogInUserWithEmailAndPasswordState> {
  final LogInUserWithEmailAndPasswordUseCase
  logInUserWithEmailAndPasswordUseCase;
  LoginUserWithEmailAndPasswordCubit(this.logInUserWithEmailAndPasswordUseCase)
    : super(LogInUserWithEmailAndPasswordInitial());
  Future<void> logInUserWithEmailAndPassword(UserData user) async {
    emit(LogInUserWithEmailAndPasswordLoading());
    var result = await logInUserWithEmailAndPasswordUseCase.execute(user);
    result.fold(
      (failure) => emit(
        LogInUserWithEmailAndPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(LogInUserWithEmailAndPasswordSuccess()),
    );
  }
}
