import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => SplashViewBodyState();
}

class SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textOpacityAnimation;
  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animatedController,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animatedController,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );
    _animatedController.forward();
    _navigateToOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animatedController,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Transform.scale(
                scale: _logoScaleAnimation.value,
                child: SvgPicture.asset(
                  AssetsManager.logo,
                  width: 113.w,
                  height: 113.h,
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: _textOpacityAnimation.value,
                child: Text(
                  StringsManager.appName.tr(),
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToOnBoarding() async {
    if (CacheData.getData(key: CacheKeys.kONBOARDING) == null) {
      await Future.delayed(
        Duration(milliseconds: 2000),
        () => GoRouter.of(context).go(AppRouter.kOnboardingView),
      );
    } else {
      if (getIt.get<FirebaseAuth>().currentUser != null) {
        await Future.delayed(
          Duration(milliseconds: 2000),
          () => GoRouter.of(context).go(AppRouter.kHomeView),
        );
      } else {
        await Future.delayed(
          Duration(milliseconds: 2000),
          () => GoRouter.of(context).go(AppRouter.kAuthView),
        );
      }
    }
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }
}
