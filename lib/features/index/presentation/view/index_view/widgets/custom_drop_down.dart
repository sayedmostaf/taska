import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/index/presentation/manager/get_task_by_day_cubit/get_task_by_day_cubit.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.selectedValue});
  final String selectedValue;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> values = ['today', 'tomorrow', 'yesterday'];
  final List<String> titles = [
    StringsManager.today.tr(),
    StringsManager.tomorrow.tr(),
    StringsManager.yesterday.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.21)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: PopupMenuButton(
            itemBuilder: (context) => List.generate(
              titles.length,
              (int index) => PopupMenuItem<String>(
                value: values[index],
                child: Text(
                  titles[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            onSelected: (p0) {
              setState(() {
                if (p0 == 'today') {
                  BlocProvider.of<GetTasksByDayCubit>(context).getTaskByDay(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      0,
                      0,
                      0,
                    ),
                  );
                } else if (p0 == 'tomorrow') {
                  BlocProvider.of<GetTasksByDayCubit>(context).getTaskByDay(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day + 1,
                      0,
                      0,
                      0,
                    ),
                  );
                } else if (p0 == 'yesterday') {
                  BlocProvider.of<GetTasksByDayCubit>(context).getTaskByDay(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day - 1,
                      0,
                      0,
                      0,
                    ),
                  );
                }
              });
            },
            offset: Offset.fromDirection(1.5, 44.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: 120.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectedValue,
                    style: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Colors.white)
                        : Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Colors.black),
                  ),
                  Icon(Icons.expand_more, size: 26.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
