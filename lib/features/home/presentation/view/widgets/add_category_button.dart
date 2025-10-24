import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/functions/blend_colors.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kCreateCategoryView);
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorManager.addCategoryColor,
            ),
            child: Icon(
              CustomIcons.add_icon,
              color: blendColors(ColorManager.addCategoryColor, Colors.black),
            ),
          ),
        ),
        Text(
          StringsManager.createNew,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
