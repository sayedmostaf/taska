import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:taska/features/auth/presentation/manager/sign_out_cubit/sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase signOutUseCase;
  SignOutCubit(this.signOutUseCase) : super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());
    var result = await signOutUseCase.execute();
    result.fold(
      (failure) => emit(SignOutFailure(errMessage: failure.message)),
      (r) => emit(SignOutSuccess()),
    );
  }
}
