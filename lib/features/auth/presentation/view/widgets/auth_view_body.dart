import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/auth/presentation/view/widgets/custom_login_button.dart';
import 'package:taska/features/auth/presentation/view/widgets/login_view.dart';
import 'package:taska/features/auth/presentation/view/widgets/register_view.dart';

class AuthViewBody extends StatefulWidget {
  const AuthViewBody({super.key});

  @override
  State<AuthViewBody> createState() => _AuthViewBodyState();
}

class _AuthViewBodyState extends State<AuthViewBody> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverSizedBox(height: 80.h),
        SliverToBoxAdapter(child: isLogin ? LoginView() : RegisterView()),
        SliverToBoxAdapter(child: Divider()),
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.googleIcon,
            text: StringsManager.loginWithGoogle,
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.facebookIcon,
            text: StringsManager.loginWithFacebook,
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 50.h)),
        SliverToBoxAdapter(child: _loginRegisterSwitcher(context)),
        CustomSliverSizedBox(height: 30.h),
      ],
    );
  }

  Row _loginRegisterSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin
              ? StringsManager.dontHaveAccount
              : StringsManager.alreadyHaveAccount,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin ? StringsManager.register : StringsManager.login,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.87)
                  : Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }
}
