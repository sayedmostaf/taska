import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/usecases/delete_category_use_case.dart';
import 'package:taska/features/home/presentation/manager/delete_category_cubit.dart/delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  final DeleteCategoryUseCase deleteCategoryUseCase;
  DeleteCategoryCubit(this.deleteCategoryUseCase)
    : super(DeleteCategoryInitial());
  Future<void> deleteCategory(String categoryId) async {
    emit(DeleteCategoryLoading());
    var result = await deleteCategoryUseCase.execute(categoryId);
    result.fold(
      (failure) {
        emit(DeleteCategoryFailure(errMessage: failure.message));
      },
      (categoryData) {
        emit(DeleteCategorySuccess(id: categoryId));
      },
    );
  }
}
