import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:taska/features/auth/presentation/manager/verify_email_cubit/verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;
  VerifyEmailCubit(this.verifyEmailUseCase) : super(VerifyEmailInitial());
  Future<void> verifyEmail() async {
    emit(VerifyEmailLoading());
    var result = await verifyEmailUseCase.execute();
    result.fold(
      (failure) => emit(VerifyEmailFailure(errMessage: failure.message)),
      (r) => emit(VerifyEmailSuccess()),
    );
  }
}
