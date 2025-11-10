import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_clickable_container.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/task_priority_item.dart';

class EditTaskPriority extends StatefulWidget {
  const EditTaskPriority({
    super.key,
    required this.initialPriority,
    required this.onSavedPriority,
  });
  final int initialPriority;
  final Function(int) onSavedPriority;
  @override
  State<EditTaskPriority> createState() => _EditTaskPriorityState();
}

class _EditTaskPriorityState extends State<EditTaskPriority> {
  late int selectedPriority;
  @override
  void initState() {
    super.initState();
    selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CustomIcons.flag_icon),
        SizedBox(width: 8.w),
        Text(
          StringsManager.taskPriority.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        CustomClickableContainer(
          text: selectedPriority.toString(),
          onTap: () {
            _buildTaskPriorityDialog(context);
          },
          icon: Icon(CustomIcons.flag_icon, size: 15.sp),
        ),
      ],
    );
  }

  void _buildTaskPriorityDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringsManager.taskPriority.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 5.h),
                  const Divider(),
                  SizedBox(height: 5.h),
                  _buildTaskPriorityGridView(setState),
                  SizedBox(height: 16.h),
                  SaveCancelActionButtons(
                    cancelOnPressed: () {
                      selectedPriority = widget.initialPriority;
                      widget.onSavedPriority(selectedPriority);
                      GoRouter.of(context).pop();
                    },
                    saveOnPressed: () {
                      widget.onSavedPriority(selectedPriority);
                      GoRouter.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  GridView _buildTaskPriorityGridView(StateSetter setState) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return TaskPriorityItem(
          onTap: () {
            selectedPriority = index + 1;
            setState(() {});
          },
          index: (index + 1).toString(),
          selected: selectedPriority == index + 1,
        );
      },
    );
  }
}
