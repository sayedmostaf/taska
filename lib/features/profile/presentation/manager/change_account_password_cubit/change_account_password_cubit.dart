import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/profile/domain/usecases/change_account_password_usecase.dart';
import 'package:taska/features/profile/presentation/manager/change_account_password_cubit/change_account_password_state.dart';

class ChangeAccountPasswordCubit extends Cubit<ChangeAccountPasswordState> {
  ChangeAccountPasswordCubit(this.changeAccountPasswordUseCase)
    : super(ChangeAccountPasswordInitial());
  final ChangeAccountPasswordUseCase changeAccountPasswordUseCase;
  Future<void> changeAccountPassword(
    String oldPassword,
    String newPassword,
  ) async {
    emit(ChangeAccountPasswordLoading());
    var res = await changeAccountPasswordUseCase.execute((
      oldPassword,
      newPassword,
    ));
    res.fold(
      (failure) =>
          emit(ChangeAccountPasswordFailure(errMessage: failure.message)),
      (success) => emit(ChangeAccountPasswordSuccess()),
    );
  }
}
