import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/custom_list_tile.dart';
import 'package:taska/main.dart';

class SettingsListTitles extends StatefulWidget {
  const SettingsListTitles({super.key});

  @override
  State<SettingsListTitles> createState() => _SettingsListTitlesState();
}

class _SettingsListTitlesState extends State<SettingsListTitles> {
  final Map<String, Locale> locales = {
    StringsManager.english.tr(): const Locale('en'),
    StringsManager.french.tr(): const Locale('fr'),
    StringsManager.arabic.tr(): const Locale('ar'),
    StringsManager.german.tr(): const Locale('de'),
    StringsManager.spanish.tr(): const Locale('es'),
    StringsManager.hindi.tr(): const Locale('hi'),
    StringsManager.chinese.tr(): const Locale('zh'),
  };
  final Map<String, ThemeMode> themes = {
    StringsManager.lightMode.tr(): ThemeMode.light,
    StringsManager.darkMode.tr(): ThemeMode.dark,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          icon: CustomIcons.change_theme_icon,
          name: StringsManager.changeAppColor.tr(),
          onTap: () {
            _showDynamicDialog(
              context: context,
              dialogTitle: StringsManager.changeAppColor.tr(),
              options: themes.keys.toList(),
              groupValue: notifier.value == ThemeMode.dark
                  ? StringsManager.darkMode.tr()
                  : StringsManager.lightMode.tr(),
              onChanged: (value) {
                notifier.value = themes[value]!;
                value == StringsManager.lightMode.tr()
                    ? CacheData.setData(
                        key: CacheKeys.kDARKMODE,
                        value: CacheValues.LIGHT,
                      )
                    : CacheData.setData(
                        key: CacheKeys.kDARKMODE,
                        value: CacheValues.DARK,
                      );
              },
            );
          },
        ),
        SizedBox(height: 16.h),
        CustomListTile(
          icon: CustomIcons.language_icon,
          name: StringsManager.changeAppLanguage.tr(),
          onTap: () {
            _showDynamicDialog(
              context: context,
              dialogTitle: StringsManager.changeAppLanguage.tr(),
              options: locales.keys.toList(),
              groupValue: getKeyForLocale(context.locale, locales)!,
              onChanged: (value) {
                context.setLocale(locales[value]!);
                GoRouter.of(context).go(AppRouter.kSplashView);
              },
            );
          },
        ),
      ],
    );
  }

  String? getKeyForLocale(dynamic value, Map<String, dynamic> locales) {
    for (var entry in locales.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
    return null;
  }

  void _showDynamicDialog({
    required BuildContext context,
    required String dialogTitle,
    required List<String> options,
    required String groupValue,
    required Function(String) onChanged,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                              dialogTitle == StringsManager.changeAppColor.tr()
                                  ? CustomIcons.change_theme_icon
                                  : CustomIcons.language_icon,
                              color: ColorManager.primaryColor,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              dialogTitle,
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
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: options.map((option) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              title: Text(
                                option,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              value: option,
                              groupValue: groupValue,
                              activeColor: ColorManager.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  onChanged(value!);
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
