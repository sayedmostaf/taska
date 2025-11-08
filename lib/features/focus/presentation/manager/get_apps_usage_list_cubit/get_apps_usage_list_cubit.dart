import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/focus/domain/usecases/get_apps_usage_list_use_case.dart';
import 'package:taska/features/focus/presentation/manager/get_apps_usage_list_cubit/get_apps_usage_list_state.dart';

class GetAppsUsageListCubit extends Cubit<GetAppsUsageListState> {
  GetAppsUsageListCubit(this.getAppsUsageListUseCase)
    : super(GetAppsUsageListInitial());
  final GetAppsUsageListUseCase getAppsUsageListUseCase;
  Future<void> getAppsUsageList() async {
    emit(GetAppsUsageListLoading());
    var result = await getAppsUsageListUseCase.execute();
    result.fold(
      (failure) {
        return emit(GetAppsUsageListFailure(errMessage: failure.message));
      },
      (appInfos) {
        return emit(GetAppsUsageListSuccess(appInfos: appInfos));
      },
    );
  }
}
