import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_simple_app_bar.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/focus/presentation/view/widgets/application_item.dart';
import 'package:taska/features/focus/presentation/view/widgets/counter_timer_widget.dart'
    show CounterTimerWidget;
import 'package:taska/features/focus/presentation/view/widgets/overview_section.dart';

class FocusViewBody extends StatelessWidget {
  const FocusViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 56.h),
          SliverToBoxAdapter(
            child: CustomSimpleAppBar(title: StringsManager.focus),
          ),
          CustomSliverSizedBox(height: 56.h),
          SliverToBoxAdapter(child: CounterTimerWidget()),
          CustomSliverSizedBox(height: 50.h),
          SliverToBoxAdapter(child: OverviewSection()),
          CustomSliverSizedBox(height: 25.h),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.applications,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: ApplicationItem(appName: 'Instagram', hours: '5h'),
              ),
              childCount: 5,
            ),
          ),
          CustomSliverSizedBox(height: 30.h),
        ],
      ),
    );
  }
}
