import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:taska/features/auth/presentation/manager/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgotPasswordCubit(this.forgetPasswordUseCase)
    : super(ForgetPasswordInitial());
  Future<void> forgotPassword(String email) async {
    emit(ForgetPasswordLoading());
    var result = await forgetPasswordUseCase.execute(email);
    result.fold(
      (failure) => emit(
        ForgetPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(ForgetPasswordSuccess()),
    );
  }
}
