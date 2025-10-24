import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';

class CategoryIconSection extends StatefulWidget {
  const CategoryIconSection({super.key});

  @override
  State<CategoryIconSection> createState() => _CategoryIconSectionState();
}

class _CategoryIconSectionState extends State<CategoryIconSection> {
  IconData? icon;

  Future<void> _pickIcon() async {
    final IconPickerIcon? pickedIcon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [
          IconPack.cupertino,
          IconPack.fontAwesomeIcons,
          IconPack.lineAwesomeIcons,
          IconPack.material,
        ],
      ),
    );

    if (pickedIcon == null) return;

    setState(() {
      icon = pickedIcon.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryIcon,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null)
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.21),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(icon, size: 28.sp),
              )
            else
              const SizedBox(),

            ElevatedButton(
              onPressed: _pickIcon,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              ),
              child: Text(
                StringsManager.chooseIcon,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),
      ],
    );
  }
}
