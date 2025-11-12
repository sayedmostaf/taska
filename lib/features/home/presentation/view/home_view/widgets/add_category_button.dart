import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/utils/functions/blend_colors.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';

class AddCategoryButton extends StatefulWidget {
  const AddCategoryButton({super.key, required this.getCategoriesCubit});
  final GetCategoriesCubit getCategoriesCubit;
  @override
  State<AddCategoryButton> createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kCreateCategoryView,
              extra: widget.getCategoriesCubit,
            );
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
        Flexible(
          child: FittedBox(
            child: Text(
              StringsManager.createNew.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
