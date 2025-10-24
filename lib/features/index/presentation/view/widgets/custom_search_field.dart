import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        style: Theme.of(context).textTheme.headlineSmall,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CustomIcons.search_icon,
            color: ColorManager.greyColor,
          ),
          hintText: StringsManager.search,
        ),
      ),
    );
  }
}
