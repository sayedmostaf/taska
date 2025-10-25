import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/features/home/presentation/view/widgets/add_task_form.dart';

class EditTaskNameAndDescription extends StatelessWidget {
  const EditTaskNameAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Do math', style: Theme.of(context).textTheme.titleMedium),
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
          'Do chapter 2 to 5 next week',
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
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.editTitleAndDescription.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 5.h),
              Divider(),
              SizedBox(height: 5.h),
              AddTaskForm(),
              SizedBox(height: 10.h),
              SaveCancelActionButtons(
                cancelOnPressed: () => GoRouter.of(context).pop(context),
                saveOnPressed: () => GoRouter.of(context).pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
