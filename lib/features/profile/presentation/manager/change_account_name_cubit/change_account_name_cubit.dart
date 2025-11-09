import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/profile/domain/usecases/change_account_name_usecase.dart';
import 'package:taska/features/profile/presentation/manager/change_account_name_cubit/change_account_name_state.dart';

class ChangeAccountNameCubit extends Cubit<ChangeAccountNameState> {
  ChangeAccountNameCubit(this.changeAccountNameUseCase)
    : super(ChangeAccountNameInitial());
  final ChangeAccountNameUseCase changeAccountNameUseCase;
  Future<void> changeAccountName(String name) async {
    emit(ChangeAccountNameLoading());
    var res = await changeAccountNameUseCase.execute(name);
    res.fold(
      (failure) => emit(ChangeAccountNameFailure(errMessage: failure.message)),
      (success) => emit(ChangeAccountNameSuccess()),
    );
  }
}
