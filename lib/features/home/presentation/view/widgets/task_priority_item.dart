import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';

class TaskPriorityItem extends StatelessWidget {
  const TaskPriorityItem({
    super.key,
    this.onTap,
    required this.index,
    required this.selected,
  });
  final Function()? onTap;
  final String index;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: selected
              ? ColorManager.primaryColor
              : Theme.of(context).brightness == Brightness.dark
              ? ColorManager.disabledColor
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CustomIcons.flag_icon,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : selected
                  ? Colors.white
                  : Colors.black,
            ),
            SizedBox(height: 5.h),
            Text(
              index,
              style: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).textTheme.headlineSmall
                  : selected
                  ? Theme.of(
                      context,
                    ).textTheme.headlineSmall!.copyWith(color: Colors.white)
                  : Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
