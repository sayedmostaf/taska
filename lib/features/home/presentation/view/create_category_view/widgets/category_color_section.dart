import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/functions/extensions.dart';
import 'package:taska/core/utils/strings_manager.dart';

class CategoryColorSection extends StatefulWidget {
  const CategoryColorSection({super.key, required this.onChanged});
  final Function(String?) onChanged;

  @override
  State<CategoryColorSection> createState() => _CategoryColorSectionState();
}

class _CategoryColorSectionState extends State<CategoryColorSection> {
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryColor.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            color == null
                ? SizedBox()
                : Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                _buildColorPicker(context);
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  StringsManager.chooseColor.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _buildColorPicker(BuildContext context) {
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
                          Icons.palette_outlined,
                          color: ColorManager.primaryColor,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          StringsManager.pickAColor.tr(),
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
                    child: ColorPicker(
                      pickerColor: color ?? ColorManager.primaryColor,
                      onColorChanged: (Color selectedColor) {
                        color = selectedColor;
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text(
                          StringsManager.cancel.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: ColorManager.primaryColor),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      ElevatedButton(
                        onPressed: () {
                          color ??= ColorManager.primaryColor;
                          widget.onChanged(color?.toHex());
                          setState(() {});
                          GoRouter.of(context).pop();
                        },
                        child: Text(
                          StringsManager.save.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
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
