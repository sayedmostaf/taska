import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/entities/user.dart';
import 'package:taska/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';
import 'package:taska/features/auth/presentation/manager/register_user_with_email_and_password/register_user_with_email_and_password_state.dart';


class RegisterUserWithEmailAndPasswordCubit
    extends Cubit<RegisterUserWithEmailAndPasswordState> {
  final RegisterUserWithEmailAndPasswordUseCase
  registerUserWithEmailAndPasswordUseCase;
  RegisterUserWithEmailAndPasswordCubit(
    this.registerUserWithEmailAndPasswordUseCase,
  ) : super(RegisterUserWithEmailAndPasswordInitial());
  Future<void> registerUserWithEmailAndPassword(UserData user) async {
    emit(RegisterUserWithEmailAndPasswordLoading());
    var result = await registerUserWithEmailAndPasswordUseCase.execute(user);
    result.fold(
      (failure) => emit(
        RegisterUserWithEmailAndPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(RegisterUserWithEmailAndPasswordSuccess()),
    );
  }
}
