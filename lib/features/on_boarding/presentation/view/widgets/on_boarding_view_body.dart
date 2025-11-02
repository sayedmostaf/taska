import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/on_boarding/presentation/view/widgets/on_boarding_action_buttons.dart';
import 'package:taska/features/on_boarding/presentation/view/widgets/page_index_indicator.dart';
import 'package:taska/features/on_boarding/presentation/view/widgets/page_view_body.dart';
import 'package:taska/features/on_boarding/presentation/view/widgets/skip_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 58.h),
          SkipButton(
            text: StringsManager.skip.tr(),
            onPressed: () {
              GoRouter.of(context).go(AppRouter.kAuthView);
            },
          ),
          PageViewBody(controller: controller),
          PageIndexIndicator(controller: controller),
          SizedBox(height: 50.h),
          OnBoardingActionButtons(controller: controller),
          SizedBox(height: 62.h),
        ],
      ),
    );
  }
}
