import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_simple_app_bar.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/calender/presentation/view/widgets/calendar.dart';
import 'package:taska/features/calender/presentation/view/widgets/day_choices_buttons.dart';
import 'package:taska/features/index/presentation/view/index_view/index_view.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/task_item.dart';

class CalendarViewBody extends StatelessWidget {
  const CalendarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CustomSliverSizedBox(height: 56.h),
        SliverToBoxAdapter(
          child: CustomSimpleAppBar(title: StringsManager.calendar),
        ),
        CustomSliverSizedBox(height: 16.h),
        SliverToBoxAdapter(child: Calendar()),
        CustomSliverSizedBox(height: 20.h),
        SliverToBoxAdapter(child: DayChoicesButtons()),
        CustomSliverSizedBox(height: 8.h),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
              child: TaskItem(taskState: TaskState.active),
            ),
            childCount: 4,
          ),
        ),
        CustomSliverSizedBox(height: 30.h),
      ],
    );
  }
}
