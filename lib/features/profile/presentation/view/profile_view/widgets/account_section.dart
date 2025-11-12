import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/profile/domain/usecases/change_account_name_usecase.dart';
import 'package:taska/features/profile/domain/usecases/change_account_password_usecase.dart';
import 'package:taska/features/profile/domain/usecases/change_account_photo_usecase.dart';
import 'package:taska/features/profile/presentation/manager/change_account_name_cubit/change_account_name_cubit.dart';
import 'package:taska/features/profile/presentation/manager/change_account_name_cubit/change_account_name_state.dart';
import 'package:taska/features/profile/presentation/manager/change_account_password_cubit/change_account_password_cubit.dart';
import 'package:taska/features/profile/presentation/manager/change_account_password_cubit/change_account_password_state.dart';
import 'package:taska/features/profile/presentation/manager/change_account_photo_cubit/change_account_photo_cubit.dart';
import 'package:taska/features/profile/presentation/manager/change_account_photo_cubit/change_account_photo_state.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/custom_list_tile.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/custom_profile_section_title.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({super.key});

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  final List<IconData> icons = [
    CustomIcons.inactive_profile_icon,
    CustomIcons.password_icon,
    CustomIcons.camera_icon,
  ];

  final List<String> names = [
    StringsManager.changeAccountName.tr(),
    StringsManager.changeAccountPassword.tr(),
    StringsManager.changeAccountImage.tr(),
  ];
  late List<void Function(BuildContext context)> functions;
  @override
  void initState() {
    super.initState();

    functions = [
      _buildChangeAccountName,
      _buildChangeAccountPassword,
      _buildImagePicker,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomProfileSectionTitle(title: StringsManager.account.tr()),
        SizedBox(height: 5.h),
        Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomListTile(
                icon: icons[index],
                name: names[index],
                onTap: () {
                  functions[index](context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _buildImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => BlocProvider(
        create: (context) =>
            ChangeAccountPhotoCubit(getIt.get<ChangeAccountPhotoUseCase>()),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child:
                  BlocListener<
                    ChangeAccountPhotoCubit,
                    ChangeAccountPhotoState
                  >(
                    listener: (context, state) {
                      if (state is ChangeAccountPhotoLoading) {
                        CustomLoadingAnimation.buildLoadingIndicator(context);
                      } else if (state is ChangeAccountPhotoFailure) {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pop();
                        MotionToast.error(
                          title: const Text('Error'),
                          description: Text(state.errMessage),
                          animationType: AnimationType.slideInFromTop,
                          toastAlignment: Alignment.topCenter,
                        ).show(context);
                      } else if (state is ChangeAccountPhotoSuccess) {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pop();
                        MotionToast.success(
                          title: const Text('Success'),
                          description: Text(
                            StringsManager.profilePhotoUpdatedSuccessfully.tr(),
                          ),
                          animationType: AnimationType.slideInFromTop,
                          toastAlignment: Alignment.topCenter,
                        ).show(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            File? image = await _getImage(ImageSource.gallery);
                            if (image != null && context.mounted) {
                              BlocProvider.of<ChangeAccountPhotoCubit>(
                                context,
                              ).changeAccountPhoto(image);
                            }
                          },
                          child: Icon(Icons.image, size: 50.sp),
                        ),
                        GestureDetector(
                          onTap: () async {
                            File? image = await _getImage(ImageSource.camera);
                            if (image != null && context.mounted) {
                              BlocProvider.of<ChangeAccountPhotoCubit>(
                                context,
                              ).changeAccountPhoto(image);
                            }
                          },
                          child: Icon(Icons.camera_alt, size: 50.sp),
                        ),
                      ],
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }

  Future<File?> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void _buildChangeAccountPassword(BuildContext context) {
    final GlobalKey<FormFieldState<String>> oldPasswordKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> newPasswordKey =
        GlobalKey<FormFieldState<String>>();
    late String oldPassword;
    late String newPassword;
    bool oldPasswordObsecured = true;
    bool newPasswordObsecured = true;
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => BlocProvider(
        create: (context) => ChangeAccountPasswordCubit(
          getIt.get<ChangeAccountPasswordUseCase>(),
        ),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
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
                              color: ColorManager.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              color: ColorManager.primaryColor,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              StringsManager.changeAccountPassword.tr(),
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
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
                          TextFormField(
                            key: oldPasswordKey,
                            style: Theme.of(context).textTheme.headlineSmall,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    oldPasswordObsecured =
                                        !oldPasswordObsecured;
                                  });
                                },
                                icon: Icon(
                                  oldPasswordObsecured
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  size: 24.sp,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: Text(
                                StringsManager.oldPassword.tr(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              hintText: StringsManager.oldPassword.tr(),
                            ),
                            obscureText: oldPasswordObsecured,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return StringsManager.passwordValidation.tr();
                              }
                              return null;
                            },
                            onChanged: (value) {
                              oldPassword = value;
                            },
                            onSaved: (value) {
                              oldPassword = value!;
                            },
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            key: newPasswordKey,
                            style: Theme.of(context).textTheme.headlineSmall,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    newPasswordObsecured =
                                        !newPasswordObsecured;
                                  });
                                },
                                icon: Icon(
                                  newPasswordObsecured
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  size: 24.sp,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: Text(
                                StringsManager.newPassword.tr(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              hintText: StringsManager.newPassword.tr(),
                            ),
                            obscureText: newPasswordObsecured,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return StringsManager.passwordValidation.tr();
                              }
                              if (value == oldPassword) {
                                return StringsManager.oldNewPassword.tr();
                              }
                              String validationMessage = _validatePassword(
                                value,
                              );
                              if (validationMessage.isNotEmpty) {
                                return validationMessage;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              newPassword = value!;
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
                          BlocListener<
                            ChangeAccountPasswordCubit,
                            ChangeAccountPasswordState
                          >(
                            listener: (context, state) {
                              if (state is ChangeAccountPasswordLoading) {
                                CustomLoadingAnimation.buildLoadingIndicator(
                                  context,
                                );
                              } else if (state
                                  is ChangeAccountPasswordFailure) {
                                GoRouter.of(context).pop();
                                MotionToast.error(
                                  title: const Text('Error'),
                                  description: Text(state.errMessage),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                              } else if (state
                                  is ChangeAccountPasswordSuccess) {
                                GoRouter.of(context).pop();
                                GoRouter.of(context).pop();
                                MotionToast.success(
                                  title: const Text('Success'),
                                  description: Text(
                                    StringsManager.passwordUpdatedSuccessfully
                                        .tr(),
                                  ),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                              }
                            },
                            child: SaveCancelActionButtons(
                              cancelOnPressed: () {
                                GoRouter.of(context).pop();
                              },
                              saveOnPressed: () {
                                if (oldPasswordKey.currentState!.validate()) {
                                  oldPasswordKey.currentState!.save();
                                  if (newPasswordKey.currentState!.validate()) {
                                    newPasswordKey.currentState!.save();
                                    BlocProvider.of<ChangeAccountPasswordCubit>(
                                      context,
                                    ).changeAccountPassword(
                                      oldPassword,
                                      newPassword,
                                    );
                                  }
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

  String _validatePassword(String password) {
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp digitRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]');
    int minLength = 6;
    int maxLength = 4096;

    if (!lowercaseRegex.hasMatch(password)) {
      return StringsManager.lowercaseValidation.tr();
    }

    if (!uppercaseRegex.hasMatch(password)) {
      return StringsManager.uppercaseValidation.tr();
    }

    if (!digitRegex.hasMatch(password)) {
      return StringsManager.numberValidation.tr();
    }

    if (!specialCharRegex.hasMatch(password)) {
      return StringsManager.specialValidation.tr();
    }

    if (password.length < minLength || password.length > maxLength) {
      return StringsManager.lengthValidation.tr();
    }

    return '';
  }

  void _buildChangeAccountName(BuildContext context) async {
    final GlobalKey<FormFieldState<String>> changeNameKey =
        GlobalKey<FormFieldState<String>>();

    await showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => BlocProvider(
        create: (context) =>
            ChangeAccountNameCubit(getIt.get<ChangeAccountNameUseCase>()),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
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
                              color: ColorManager.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: ColorManager.primaryColor,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              StringsManager.changeAccountName.tr(),
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
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
                          TextFormField(
                            key: changeNameKey,
                            style: Theme.of(context).textTheme.headlineSmall,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              label: Text(
                                StringsManager.accountName.tr(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              hintText: StringsManager.accountName.tr(),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return StringsManager.nameValidation.tr();
                              }
                              return null;
                            },
                            onSaved: (value) {
                              BlocProvider.of<ChangeAccountNameCubit>(
                                context,
                              ).changeAccountName(value!);
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
                          BlocListener<
                            ChangeAccountNameCubit,
                            ChangeAccountNameState
                          >(
                            listener: (context, state) {
                              if (state is ChangeAccountNameLoading) {
                                CustomLoadingAnimation.buildLoadingIndicator(
                                  context,
                                );
                              } else if (state is ChangeAccountNameFailure) {
                                GoRouter.of(context).pop();
                                MotionToast.error(
                                  title: const Text('Error'),
                                  description: Text(state.errMessage),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                              } else if (state is ChangeAccountNameSuccess) {
                                GoRouter.of(context).pop();
                                GoRouter.of(context).pop();
                                MotionToast.success(
                                  title: const Text('Success'),
                                  description: Text(
                                    StringsManager.nameUpdatedSuccessfully.tr(),
                                  ),
                                  animationType: AnimationType.slideInFromTop,
                                  toastAlignment: Alignment.topCenter,
                                ).show(context);
                              }
                            },
                            child: SaveCancelActionButtons(
                              cancelOnPressed: () {
                                GoRouter.of(context).pop();
                              },
                              saveOnPressed: () {
                                if (changeNameKey.currentState!.validate()) {
                                  changeNameKey.currentState!.save();
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
