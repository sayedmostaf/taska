import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/add_task_form.dart';

class EditTaskNameAndDescription extends StatefulWidget {
  const EditTaskNameAndDescription({
    super.key,
    required this.task,
    required this.onSavedTaskDescription,
    required this.onSavedTaskTitle,
  });
  final TaskEntity task;
  final Function(String?) onSavedTaskDescription;
  final Function(String?) onSavedTaskTitle;

  @override
  State<EditTaskNameAndDescription> createState() =>
      _EditTaskNameAndDescriptionState();
}

class _EditTaskNameAndDescriptionState
    extends State<EditTaskNameAndDescription> {
  String? name, description;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    name = widget.task.name;
    description = widget.task.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name!,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                _buildEditTaskTitleAndDescriptionDialog(context);
              },
              icon: Icon(CustomIcons.edit_icon),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Text(
          description ?? "",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(color: Colors.grey[500]),
        ),
      ],
    );
  }

  void _buildEditTaskTitleAndDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
          child: Container(
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
                          CustomIcons.edit_icon,
                          color: ColorManager.primaryColor,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          StringsManager.editTitleAndDescription.tr(),
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
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: AddTaskForm(
                      formKey: formKey,
                      initialName: name,
                      initialDescription: description,
                      onSavedTaskDescription: (p0) {
                        setState(() {
                          description = p0;
                        });
                        widget.onSavedTaskDescription(p0);
                      },
                      onSavedTaskTitle: (p0) {
                        setState(() {
                          name = p0;
                        });
                        widget.onSavedTaskTitle(p0);
                      },
                    ),
                  ),
                ),
                // Actions
                Divider(height: 1, thickness: 1),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: SaveCancelActionButtons(
                    cancelOnPressed: () => GoRouter.of(context).pop(context),
                    saveOnPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        GoRouter.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
