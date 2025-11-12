import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/features/calender/presentation/manager/get_tasks_by_calender_day_cubit/get_tasks_by_calender_day_cubit.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/home/presentation/manager/create_task_cubit/create_task_cubit.dart';
import 'package:taska/features/home/presentation/manager/create_task_cubit/create_task_state.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/add_task_action_buttons.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/add_task_form.dart';
import 'package:taska/features/index/presentation/manager/get_task_by_day_cubit/get_task_by_day_cubit.dart';
import 'package:uuid/uuid.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  bool isShowing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? taskTitle, taskDescription;
  DateTime? time;
  CategoryEntity? categoryEntity;
  int? priority;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            if (isShowing) {
              GoRouter.of(context).pop();
            } else {
              _showCustomBottomSheet(context);
            }
          },
          shape: CircleBorder(),
          backgroundColor: ColorManager.primaryColor,
          child: Icon(CustomIcons.add_icon, color: Colors.white),
        ),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    isShowing = true;
    showBottomSheet(
      context: context,
      builder: (context) => IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(
            left: 25.w,
            right: 25.w,
            bottom: 10.h,
            top: 33.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  StringsManager.addTask.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 15.h),
              AddTaskForm(
                formKey: formKey,
                onSavedTaskTitle: (p0) {
                  taskTitle = p0;
                },
                onSavedTaskDescription: (p0) {
                  taskDescription = p0;
                },
              ),
              Spacer(),
              BlocListener<CreateTaskCubit, CreateTaskState>(
                listener: (context, state) {
                  if (state is CreateTaskLoading) {
                    CustomLoadingAnimation.buildLoadingIndicator(context);
                  } else if (state is CreateTaskFailure) {
                    GoRouter.of(context).pop();
                    MotionToast.error(
                      title: const Text('Error'),
                      description: Text(state.errMessage),
                      animationType: AnimationType.slideInFromTop,
                      toastAlignment: Alignment.topCenter,
                    ).show(context);
                  } else if (state is CreateTaskSuccess) {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                    MotionToast.success(
                      title: const Text('Success'),
                      description: Text(
                        StringsManager.taskCreatedSuccessfully.tr(),
                      ),
                      animationType: AnimationType.slideInFromTop,
                      toastAlignment: Alignment.topCenter,
                    ).show(context);
                    BlocProvider.of<GetTasksByDayCubit>(
                      context,
                    ).getTaskByDay(null);
                    BlocProvider.of<GetTasksByCalendarDayCubit>(
                      context,
                    ).getTasksByDay(day: null, isCompleted: null);
                  }
                },
                child: AddTaskActionButtons(
                  onSend: () {
                    if (time == null) {
                      MotionToast.warning(
                        title: const Text('Notice'),
                        description: Text(StringsManager.pleasePickATime.tr()),
                        animationType: AnimationType.slideInFromTop,
                        toastAlignment: Alignment.topCenter,
                      ).show(context);
                      return;
                    }
                    if (categoryEntity == null) {
                      MotionToast.warning(
                        title: const Text('Notice'),
                        description: Text(StringsManager.pleasePickACategory),
                        animationType: AnimationType.slideInFromTop,
                        toastAlignment: Alignment.topCenter,
                      ).show(context);
                      return;
                    }
                    if (priority == null) {
                      MotionToast.warning(
                        title: const Text('Notice'),
                        description: Text(
                          StringsManager.pleaseSelectAPriorityLevel.tr(),
                        ),
                        animationType: AnimationType.slideInFromTop,
                        toastAlignment: Alignment.topCenter,
                      ).show(context);
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      BlocProvider.of<CreateTaskCubit>(context).createTask(
                        TaskEntity(
                          id: Uuid().v4(),
                          name: taskTitle!,
                          description: taskDescription ?? "",
                          status: 'pending',
                          category: categoryEntity!,
                          priority: priority!,
                          utcTime: time!,
                        ),
                      );
                    }
                  },
                  onSelectDateTime: (date) {
                    time = date;
                  },
                  onSelectCategory: (category) {
                    categoryEntity = category;
                  },
                  onSelectPriority: (priority) {
                    this.priority = priority;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ).closed.whenComplete(() {
      isShowing = false;
    });
  }
}
