import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/home/domain/usecases/get_all_categories_use_case.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this.getAllCategoriesUseCase)
    : super(GetCategoriesInitial());
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  Future<void> getAllCategories() async {
    emit(GetCategoriesLoading());
    var result = await getAllCategoriesUseCase.execute();
    result.fold(
      (failure) {
        emit(GetCategoriesFailure(errMessage: failure.message));
      },
      (categoriesData) {
        emit(GetCategoriesSuccess(categories: categoriesData));
      },
    );
  }
}
