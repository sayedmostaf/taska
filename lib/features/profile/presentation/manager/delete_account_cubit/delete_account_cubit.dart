import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:taska/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.deleteAccountUseCase) : super(DeleteAccountInitial());
  final DeleteAccountUseCase deleteAccountUseCase;
  Future<void> deleteAccount(String? password) async {
    emit(DeleteAccountLoading());
    var res = await deleteAccountUseCase.execute(password);
    res.fold(
      (failure) => emit(DeleteAccountFailure(errMessage: failure.message)),
      (success) => emit(DeleteAccountSuccess()),
    );
  }
}
