import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
    required this.formKey,
    this.onSavedTaskTitle,
    this.onSavedTaskDescription,
  });
  final GlobalKey<FormState> formKey;
  final Function(String?)? onSavedTaskTitle;
  final Function(String?)? onSavedTaskDescription;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              label: Text(StringsManager.taskTitle.tr()),
              hintText: StringsManager.taskTitle.tr(),
            ),
            validator: (value) {
              if (value == null || value.length < 3) {
                return StringsManager.nameValidation.tr();
              }
              return null;
            },
            onSaved: onSavedTaskTitle,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              label: Text(StringsManager.taskDescription.tr()),
              hintText: StringsManager.taskDescription.tr(),
            ),
            onSaved: onSavedTaskDescription,
          ),
        ],
      ),
    );
  }
}
