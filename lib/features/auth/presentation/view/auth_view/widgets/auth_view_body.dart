import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/auth/presentation/manager/log_in_user_with_google_cubit/log_in_user_with_google_cubit.dart';
import 'package:taska/features/auth/presentation/manager/log_in_user_with_google_cubit/log_in_user_with_google_state.dart';
import 'package:taska/features/auth/presentation/view/auth_view/widgets/custom_login_button.dart';
import 'package:taska/features/auth/presentation/view/auth_view/widgets/login_view.dart';
import 'package:taska/features/auth/presentation/view/auth_view/widgets/register_view.dart';

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
      physics: BouncingScrollPhysics(),
      slivers: [
        CustomSliverSizedBox(height: 80.h),
        SliverToBoxAdapter(child: isLogin ? LoginView() : RegisterView()),
        SliverToBoxAdapter(child: Divider()),
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        SliverToBoxAdapter(
          child:
              BlocListener<LogInUserWithGoogleCubit, LogInUserWithGoogleState>(
                listener: (context, state) {
                  if (state is LogInUserWithGoogleLoading) {
                    CustomLoadingAnimation.buildLoadingIndicator(context);
                  } else if (state is LogInUserWithGoogleFailure) {
                    GoRouter.of(context).pop();
                    Fluttertoast.showToast(
                      msg: state.errMessage,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  } else if (state is LogInUserWithGoogleSuccess) {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).go(AppRouter.kHomeView);
                  }
                },
                child: CustomLoginButton(
                  asset: AssetsManager.googleIcon,
                  text: StringsManager.loginWithGoogle.tr(),
                  onPressed: () {
                    BlocProvider.of<LogInUserWithGoogleCubit>(
                      context,
                    ).logInUserWithGoogle();
                  },
                ),
              ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
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
              ? StringsManager.dontHaveAccount.tr()
              : StringsManager.alreadyHaveAccount.tr(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin ? StringsManager.register.tr() : StringsManager.login.tr(),
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
