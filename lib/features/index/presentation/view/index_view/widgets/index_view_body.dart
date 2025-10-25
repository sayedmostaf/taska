import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_clickable_container.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/index/presentation/view/index_view/index_view.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/custom_drop_down.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/custom_index_app_bar.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/custom_search_field.dart';
import 'package:taska/features/index/presentation/view/index_view/widgets/task_item.dart';

class IndexViewBody extends StatelessWidget {
  const IndexViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 56.h),
          SliverToBoxAdapter(child: CustomIndexAppBar()),
          CustomSliverSizedBox(height: 15.h),
          SliverToBoxAdapter(child: CustomSearchField()),
          CustomSliverSizedBox(height: 30.h),
          SliverToBoxAdapter(
            child: CustomDropDown(
              values: ['tody', 'tomorrow', 'yesterday'],
              titles: [
                StringsManager.today.tr(),
                StringsManager.tomorrow.tr(),
                StringsManager.yesterday.tr(),
              ],
              onSelected: (p0) {
                log(p0);
              },
            ),
          ),
          CustomSliverSizedBox(height: 20.h),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 4,
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TaskItem(taskState: TaskState.active),
              ),
            ),
          ),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: CustomClickableContainer(
              text: StringsManager.completed.tr(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TaskItem(taskState: TaskState.completed),
              ),
              childCount: 2,
            ),
          ),
          CustomSliverSizedBox(height: 03.h),
        ],
      ),
    );
  }
}
