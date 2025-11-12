import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/custom_simple_app_bar.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/calender/presentation/manager/get_tasks_by_calender_day_cubit/get_tasks_by_calender_day_cubit.dart';
import 'package:taska/features/calender/presentation/manager/get_tasks_by_calender_day_cubit/get_tasks_by_calender_day_state.dart';
import 'package:taska/features/calender/presentation/view/widgets/calendar.dart';
import 'package:taska/features/calender/presentation/view/widgets/day_choices_buttons.dart';
import 'package:taska/features/index/domain/usecases/change_task_status_usecase.dart';
import 'package:taska/features/index/presentation/manager/change_task_status_cubit/change_task_status_cubit.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/task_item.dart';

class CalendarViewBody extends StatefulWidget {
  const CalendarViewBody({super.key});

  @override
  State<CalendarViewBody> createState() => _CalendarViewBodyState();
}

class _CalendarViewBodyState extends State<CalendarViewBody> {
  bool isCompleted = true;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomSliverSizedBox(height: 56.h),
        SliverToBoxAdapter(
          child: CustomSimpleAppBar(title: StringsManager.calendar.tr()),
        ),
        CustomSliverSizedBox(height: 16.h),
        SliverToBoxAdapter(
          child: Calendar(
            onDaySelected: (p0) {
              BlocProvider.of<GetTasksByCalendarDayCubit>(
                context,
              ).getTasksByDay(
                isCompleted: isCompleted,
                day: DateTime(p0.year, p0.month, p0.day, 0, 0, 0),
              );
            },
          ),
        ),
        CustomSliverSizedBox(height: 20.h),
        SliverToBoxAdapter(
          child: DayChoicesButtons(
            isCompleted: (p0) {
              isCompleted = p0;
              BlocProvider.of<GetTasksByCalendarDayCubit>(
                context,
              ).getTasksByDay(isCompleted: isCompleted, day: null);
            },
          ),
        ),
        CustomSliverSizedBox(height: 8.h),
        BlocBuilder<GetTasksByCalendarDayCubit, GetTasksByCalendarDayState>(
          builder: (context, state) {
            if (state is GetTasksByCalendarDayLoading) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CustomCircularIndicator(height: 200.h, width: 200.w),
                ),
              );
            } else if (state is GetTasksByCalendarDayFailure) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AssetsManager.error,
                        width: 150.w,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      StringsManager.operationNotAllowed.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              );
            } else if (state is GetTasksByCalendarDaySuccess) {
              if (state.tasks.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsManager.checklist,
                        width: 200.w,
                        height: 200.h,
                      ),
                      Text(
                        StringsManager.tapPlusToAddSomeTasks.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => BlocProvider(
                    create: (context) => ChangeTaskStatusCubit(
                      getIt.get<ChangeTaskStatusUseCase>(),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 24,
                      ),
                      child: TaskItem(task: state.tasks[index]),
                    ),
                  ),
                  childCount: state.tasks.length,
                ),
              );
            }
            return const SliverToBoxAdapter();
          },
        ),
      ],
    );
  }
}
