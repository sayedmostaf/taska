import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/functions/blend_colors.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:vibration/vibration.dart';

class TaskCategoryItem extends StatefulWidget {
  const TaskCategoryItem({
    super.key,
    required this.category,
    required this.selected,
    this.onTap,
  });
  final CategoryEntity category;

  final bool selected;
  final Function()? onTap;
  @override
  State<TaskCategoryItem> createState() => _TaskCategoryItemState();
}

class _TaskCategoryItemState extends State<TaskCategoryItem> {
  bool isVisibleDelete = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: widget.onTap,
              onLongPress: () async {
                Vibration.vibrate(duration: 100);
                setState(() {
                  isVisibleDelete = !isVisibleDelete;
                });
              },
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: widget.selected
                        ? ColorManager.primaryColor
                        : Colors.transparent,
                    width: 2.w,
                  ),
                  color: widget.category.color.toColor(),
                ),
                child: Icon(
                  IconData(
                    widget.category.iconData,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: blendColors(
                    widget.category.color.toColor()!,
                    Colors.black,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisibleDelete,
              child: Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    log('delete');
                  },
                  child: Icon(Icons.delete, color: Colors.red, size: 18.sp),
                ),
              ),
            ),
          ],
        ),
        Text(
          widget.category.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
