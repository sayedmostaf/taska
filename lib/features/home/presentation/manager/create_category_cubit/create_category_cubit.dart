import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/usecases/create_category_use_case.dart';
import 'package:taska/features/home/presentation/manager/create_category_cubit/create_category_state.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  final CreateCategoryUseCase createCategoryUseCase;
  CreateCategoryCubit({required this.createCategoryUseCase})
    : super(CreateCategoryInitial());
  Future<void> createCategory(CategoryEntity categoryEntity) async {
    emit(CreateCategoryLoading());
    var result = await createCategoryUseCase.execute(categoryEntity);
    result.fold(
      (failure) {
        emit(CreateCategoryFailure(errMessage: failure.message));
      },
      (categoryData) {
        emit(CreateCategorySuccess());
      },
    );
  }
}
