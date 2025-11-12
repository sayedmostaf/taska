import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:taska/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:taska/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountLoading) {
          CustomLoadingAnimation.buildLoadingIndicator(context);
        } else if (state is DeleteAccountFailure) {
          GoRouter.of(context).pop();
          MotionToast.error(
            title: const Text('Error'),
            description: Text(state.errMessage),
            animationType: AnimationType.slideInFromTop,
            toastAlignment: Alignment.topCenter,
          ).show(context);
        } else if (state is DeleteAccountSuccess) {
          MotionToast.success(
            title: const Text('Success'),
            description: Text(StringsManager.accountDeletedSuccessfully.tr()),
            animationType: AnimationType.slideInFromTop,
            toastAlignment: Alignment.topCenter,
          ).show(context);
          GoRouter.of(context).go(AppRouter.kAuthView);
        }
      },
      child: InkWell(
        onTap: () {
          List<UserInfo> providers = getIt
              .get<FirebaseAuth>()
              .currentUser!
              .providerData;
          bool hasPasswordProvider = providers.any(
            (provider) => provider.providerId == 'password',
          );
          if (hasPasswordProvider) {
            _buildDeleteAccount(context);
          } else {
            BlocProvider.of<DeleteAccountCubit>(context).deleteAccount(null);
          }
        },
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          height: 48.h,
          child: Row(
            children: [
              Icon(FontAwesomeIcons.trashCan, color: Colors.red),
              SizedBox(width: 10.w),
              Text(
                StringsManager.deleteAccount.tr(),
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildDeleteAccount(BuildContext context) async {
    final GlobalKey<FormFieldState<String>> deleteAccountKey =
        GlobalKey<FormFieldState<String>>();
    bool isObscured = true;
    await showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 8,
        child: BlocProvider(
          create: (context) =>
              DeleteAccountCubit(getIt.get<DeleteAccountUseCase>()),
          child: StatefulBuilder(
            builder: (context, setState) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? ColorManager.surfaceColorDark
                            : ColorManager.surfaceColorLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: ColorManager.errorColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              FontAwesomeIcons.trashCan,
                              color: ColorManager.errorColor,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              StringsManager.deleteAccount.tr(),
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: ColorManager.errorColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1),
                    // Content
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Please enter your password to confirm account deletion',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            key: deleteAccountKey,
                            style: Theme.of(context).textTheme.headlineSmall,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                                icon: Icon(
                                  isObscured
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  size: 24.sp,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: Text(
                                StringsManager.password.tr(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              hintText: StringsManager.password.tr(),
                            ),
                            obscureText: isObscured,
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return StringsManager.passwordValidation.tr();
                              }
                              return null;
                            },
                            onSaved: (value) {
                              BlocProvider.of<DeleteAccountCubit>(
                                context,
                              ).deleteAccount(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    Divider(height: 1, thickness: 1),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child:
                          BlocListener<DeleteAccountCubit, DeleteAccountState>(
                            listener: (context, state) {
                              if (state is DeleteAccountLoading) {
                                CustomLoadingAnimation.buildLoadingIndicator(
                                  context,
                                );
                              } else if (state is DeleteAccountFailure) {
                                GoRouter.of(context).pop();
                                MotionToast.error(
                                  title: const Text('Error'),
                                  description: Text(state.errMessage),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                              } else if (state is DeleteAccountSuccess) {
                                MotionToast.success(
                                  title: const Text('Success'),
                                  description: Text(
                                    StringsManager.accountDeletedSuccessfully
                                        .tr(),
                                  ),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                                GoRouter.of(context).go(AppRouter.kAuthView);
                              }
                            },
                            child: SaveCancelActionButtons(
                              cancelOnPressed: () {
                                GoRouter.of(context).pop();
                              },
                              saveOnPressed: () {
                                if (deleteAccountKey.currentState!.validate()) {
                                  deleteAccountKey.currentState!.save();
                                }
                              },
                            ),
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
