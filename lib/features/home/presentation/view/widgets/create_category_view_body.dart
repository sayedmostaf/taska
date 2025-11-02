import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/home/presentation/view/widgets/category_color_section.dart';
import 'package:taska/features/home/presentation/view/widgets/category_icon_section.dart';
import 'package:taska/features/home/presentation/view/widgets/category_name_section.dart';
import 'package:taska/features/home/presentation/view/widgets/create_category_action_buttons.dart';
import 'package:taska/features/home/presentation/view/widgets/create_category_back_arrow.dart';

class CreateCategoryViewBody extends StatelessWidget {
  const CreateCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 50.h),
          SliverToBoxAdapter(child: CreateCategoryBackArrow()),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.createNew.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(child: CategoryNameSection()),
          SliverToBoxAdapter(child: CategoryIconSection()),
          SliverToBoxAdapter(child: CategoryColorSection()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: CreateCategoryActionButtons(),
          ),
        ],
      ),
    );
  }
}
