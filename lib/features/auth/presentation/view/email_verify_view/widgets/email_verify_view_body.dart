import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/auth/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:taska/features/auth/presentation/manager/sign_out_cubit/sign_out_state.dart';
import 'package:taska/features/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:taska/features/auth/presentation/manager/verify_email_cubit/verify_email_state.dart';
import 'package:taska/features/auth/presentation/view/email_verify_view/widgets/send_email_verify.dart';

class EmailVerifyViewBody extends StatefulWidget {
  const EmailVerifyViewBody({super.key});

  @override
  State<EmailVerifyViewBody> createState() => _EmailVerifyViewBodyState();
}

class _EmailVerifyViewBodyState extends State<EmailVerifyViewBody> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        slivers: [
          CustomSliverSizedBox(height: 60.h),
          SliverToBoxAdapter(
            child: BlocListener<SignOutCubit, SignOutState>(
              listener: (context, state) {
                if (state is SignOutLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is SignOutFailure) {
                  GoRouter.of(context).pop();
                  MotionToast.error(
                    title: const Text('Error'),
                    description: Text(state.errMessage),
                    animationType: AnimationType.slideInFromTop,
                    toastAlignment: Alignment.topCenter,
                  ).show(context);
                } else if (state is SignOutSuccess) {
                  GoRouter.of(context).pop();
                  GoRouter.of(context).go(AppRouter.kAuthView);
                }
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    BlocProvider.of<SignOutCubit>(context).signOut();
                  },
                ),
              ),
            ),
          ),
          CustomSliverSizedBox(height: 40.h),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.yourEmailIsNotVerified.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
              listener: (context, state) {
                if (state is VerifyEmailLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is VerifyEmailFailure) {
                  GoRouter.of(context).pop();
                  MotionToast.error(
                    title: const Text('Error'),
                    description: Text(state.errMessage),
                    animationType: AnimationType.slideInFromTop,
                    toastAlignment: Alignment.topCenter,
                  ).show(context);
                } else if (state is VerifyEmailSuccess) {
                  GoRouter.of(context).pop();

                  MotionToast.success(
                    title: const Text('Success'),
                    description: Text(StringsManager.verificationEmail.tr()),
                    animationType: AnimationType.slideInFromTop,
                    toastAlignment: Alignment.topCenter,
                  ).show(context);
                }
              },
              child: const SendEmailVerify(),
            ),
          ),
        ],
      ),
    );
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified && context.mounted) {
      GoRouter.of(context).go(AppRouter.kHomeView);
      timer?.cancel();
    }
  }
}
