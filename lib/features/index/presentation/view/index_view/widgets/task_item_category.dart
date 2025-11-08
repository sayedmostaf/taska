import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/utils/functions/blend_colors.dart';
import 'package:taska/features/home/domain/entities/category.dart';

class TaskItemCategory extends StatelessWidget {
  const TaskItemCategory({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      height: 29.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: category.color.toColor(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Icon(
              CustomIcons.music_icon,
              size: 15.sp,
              color: blendColors(category.color.toColor()!, Colors.black),
            ),
            SizedBox(width: 5.w),
            Text(
              category.name,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
