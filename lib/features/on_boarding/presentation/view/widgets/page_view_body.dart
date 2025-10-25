import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';

class PageViewBody extends StatelessWidget {
  PageViewBody({super.key, required this.controller});
  final PageController controller;
  final List<String> images = [
    AssetsManager.onboarding1,
    AssetsManager.onboarding2,
    AssetsManager.onboarding3,
  ];
  final List<String> titles = [
    StringsManager.onboarding1.tr(),
    StringsManager.onboarding2.tr(),
    StringsManager.onboarding3.tr(),
  ];
  final List<String> subTitles = [
    StringsManager.onboarding1Description.tr(),
    StringsManager.onboarding2Description.tr(),
    StringsManager.onboarding3Description.tr(),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: 3,
        controller: controller,
        itemBuilder: (context, index) {
          return CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              CustomSliverSizedBox(height: 10.h),
              SliverToBoxAdapter(
                child: SvgPicture.asset(
                  images[index],
                  width: 213.w,
                  height: 227.h,
                ),
              ),
              CustomSliverSizedBox(height: 80.h),
              SliverToBoxAdapter(
                child: Text(
                  titles[index],
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomSliverSizedBox(height: 40.h),
              SliverToBoxAdapter(
                child: Text(
                  subTitles[index],
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
