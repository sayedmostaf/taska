import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_simple_app_bar.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/account_section.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/app_about_section.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/delete_account_button.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/log_out_button.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/profile_card.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/setting_section.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 56.h),
          SliverToBoxAdapter(
            child: CustomSimpleAppBar(title: StringsManager.profile.tr()),
          ),
          CustomSliverSizedBox(height: 24.h),
          SliverToBoxAdapter(
            child: ProfileCard(
              name: 'Sayed Mostafa',
              tasksDone: '7 Tasks Done',
              tasksMissed: '10 Tasks Missed',
            ),
          ),
          CustomSliverSizedBox(height: 32.h),
          SliverToBoxAdapter(child: SettingSection()),
          CustomSliverSizedBox(height: 16.h),
          SliverToBoxAdapter(child: AccountSection()),
          CustomSliverSizedBox(height: 8.h),
          SliverToBoxAdapter(child: AppAboutSection()),
          SliverToBoxAdapter(
            child: LogOutButton(
              onTap: () async {
                clearDatabase();
                await CacheData.removeData(key: CacheKeys.kDATE);
                await CacheData.removeData(key: CacheKeys.kSECONDS);
                getIt.get<FirebaseAuth>().signOut();
                if (context.mounted) {
                  GoRouter.of(context).go(AppRouter.kAuthView);
                }
              },
            ),
          ),
          SliverToBoxAdapter(child: DeleteAccountButton()),
          CustomSliverSizedBox(height: 30.h),
        ],
      ),
    );
  }
}
