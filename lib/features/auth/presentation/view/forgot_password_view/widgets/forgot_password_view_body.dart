import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/auth/presentation/manager/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:taska/features/auth/presentation/manager/forgot_password_cubit/forgot_password_state.dart';
import 'package:taska/features/auth/presentation/view/forgot_password_view/widgets/send_button.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final GlobalKey<FormFieldState<String>> forgetPassword =
      GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        slivers: [
          CustomSliverSizedBox(height: 60.h),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
          CustomSliverSizedBox(height: 40.h),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.sendPasswordResetEmail.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: BlocListener<ForgotPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is ForgetPasswordFailure) {
                  GoRouter.of(context).pop();
                  MotionToast.error(
                    title: const Text('Error'),
                    description: Text(state.errMessage),
                    animationType: AnimationType.slideInFromTop,
                    toastAlignment: Alignment.topCenter,
                  ).show(context);
                } else if (state is ForgetPasswordSuccess) {
                  GoRouter.of(context).pop();
                  MotionToast.success(
                    title: const Text('Success'),
                    description: Text(StringsManager.resetPassword.tr()),
                    animationType: AnimationType.slideInFromTop,
                    toastAlignment: Alignment.topCenter,
                  ).show(context);
                }
              },
              child: TextFormField(
                key: forgetPassword,
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: StringsManager.enterEmail.tr(),
                  label: Text(
                    StringsManager.email.tr(),
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                validator: _buildEmailValidation,
                onSaved: (value) {
                  BlocProvider.of<ForgotPasswordCubit>(
                    context,
                  ).forgotPassword(value!);
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SendButton(forgotPassword: forgetPassword),
          ),
        ],
      ),
    );
  }

  String? _buildEmailValidation(value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return StringsManager.emailValidation.tr();
    }
    return null;
  }
}
