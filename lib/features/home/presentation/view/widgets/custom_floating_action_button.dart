import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/home/presentation/view/widgets/add_task_action_buttons.dart';
import 'package:taska/features/home/presentation/view/widgets/add_task_form.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  bool isShowing = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (isShowing) {
          GoRouter.of(context).pop();
        } else {
          _showCustomBottomSheet(context);
        }
      },
      shape: CircleBorder(),
      backgroundColor: ColorManager.primaryColor,
      child: Icon(FontAwesomeIcons.plus, color: Colors.white),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    isShowing = true;
    showBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 255.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: 25.w,
            right: 25.w,
            bottom: 10.h,
            top: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsManager.addTask,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 15.h),
              AddTaskForm(),
              Spacer(),
              AddTaskActionButtons(),
            ],
          ),
        ),
      ),
    ).closed.whenComplete(() {
      isShowing = false;
    });
  }
}
