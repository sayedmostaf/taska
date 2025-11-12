import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_clickable_container.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/core/utils/color_manager.dart';
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
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? ColorManager.surfaceColorDark
                            : ColorManager.surfaceColorLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: ColorManager.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              CustomIcons.flag_icon,
                              color: ColorManager.primaryColor,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              StringsManager.taskPriority.tr(),
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1),
                    // Content
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: _buildTaskPriorityGridView(setState),
                    ),
                    // Actions
                    Divider(height: 1, thickness: 1),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: SaveCancelActionButtons(
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
                    ),
                  ],
                ),
              );
            },
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
