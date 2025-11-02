import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/profile/presentation/view/settings_view/widgets/settings_app_bar.dart';
import 'package:taska/features/profile/presentation/view/settings_view/widgets/settings_list_titles.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 56.h),
          SliverToBoxAdapter(child: SettingsAppBar()),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(child: Material(child: SettingsListTitles())),
        ],
      ),
    );
  }
}
