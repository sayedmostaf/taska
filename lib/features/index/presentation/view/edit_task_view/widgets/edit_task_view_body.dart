import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/delete_task.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/edit_task_category.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/edit_task_name_and_description.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/edit_task_priority.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/edit_task_time.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/save_button.dart';

class EditTaskViewBody extends StatelessWidget {
  const EditTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 55.h),
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: EditTaskNameAndDescription()),
          CustomSliverSizedBox(height: 35.h),
          SliverToBoxAdapter(child: EditTaskTime()),
          CustomSliverSizedBox(height: 35.h),
          SliverToBoxAdapter(child: EditTaskCategory()),
          CustomSliverSizedBox(height: 35.h),
          SliverToBoxAdapter(child: EditTaskPriority()),
          CustomSliverSizedBox(height: 35.h),
          SliverToBoxAdapter(child: DeleteTask(onTap: () {})),
          SliverFillRemaining(hasScrollBody: false, child: SaveButton()),
        ],
      ),
    );
  }
}
