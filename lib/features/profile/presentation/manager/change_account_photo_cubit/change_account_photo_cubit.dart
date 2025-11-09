import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/profile/domain/usecases/change_account_photo_usecase.dart';
import 'package:taska/features/profile/presentation/manager/change_account_photo_cubit/change_account_photo_state.dart';

class ChangeAccountPhotoCubit extends Cubit<ChangeAccountPhotoState> {
  ChangeAccountPhotoCubit(this.changeAccountPhotoUseCase)
    : super(ChangeAccountPhotoInitial());
  final ChangeAccountPhotoUseCase changeAccountPhotoUseCase;
  Future<void> changeAccountPhoto(File image) async {
    emit(ChangeAccountPhotoLoading());
    var res = await changeAccountPhotoUseCase.execute(image);
    res.fold(
      (failure) => emit(ChangeAccountPhotoFailure(errMessage: failure.message)),
      (success) => emit(ChangeAccountPhotoSuccess()),
    );
  }
}
