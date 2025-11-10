import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
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
          Fluttertoast.showToast(msg: state.errMessage);
        } else if (state is DeleteAccountSuccess) {
          Fluttertoast.showToast(
            msg: StringsManager.accountDeletedSuccessfully.tr(),
          );
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
      builder: (context) => Dialog(
        child: BlocProvider(
          create: (context) =>
              DeleteAccountCubit(getIt.get<DeleteAccountUseCase>()),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringsManager.deleteAccount.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 5.h),
                    const Divider(),
                    SizedBox(height: 5.h),
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
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        label: Text(
                          StringsManager.password.tr(),
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
                    SizedBox(height: 16.h),
                    BlocListener<DeleteAccountCubit, DeleteAccountState>(
                      listener: (context, state) {
                        if (state is DeleteAccountLoading) {
                          CustomLoadingAnimation.buildLoadingIndicator(context);
                        } else if (state is DeleteAccountFailure) {
                          GoRouter.of(context).pop();
                          Fluttertoast.showToast(msg: state.errMessage);
                        } else if (state is DeleteAccountSuccess) {
                          Fluttertoast.showToast(
                            msg: StringsManager.accountDeletedSuccessfully.tr(),
                          );
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
