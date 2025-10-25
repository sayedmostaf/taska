import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/custom_list_tile.dart';

class SettingsListTitles extends StatelessWidget {
  const SettingsListTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          icon: CustomIcons.change_theme_icon,
          name: StringsManager.changeAppColor,
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        CustomListTile(
          icon: CustomIcons.language_icon,
          name: StringsManager.changeAppLanguage,
          onTap: () {},
        ),
      ],
    );
  }
}
