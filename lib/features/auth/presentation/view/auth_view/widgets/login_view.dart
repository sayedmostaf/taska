import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/features/auth/domain/entities/user.dart';
import 'package:taska/features/auth/presentation/manager/login_user_with_email_and_password_cubit/login_user_with_email_and_password_cubit.dart';
import 'package:taska/features/auth/presentation/manager/login_user_with_email_and_password_cubit/login_user_with_email_and_password_state.dart';
import 'package:taska/features/auth/presentation/view/auth_view/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> formKey;
  late String email, password;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.login.tr(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 53.h),
        LoginForm(
          formKey: formKey,
          onSavedEmail: _onSavedEmail,
          onSavedPassword: _onSavedPassword,
        ),
        SizedBox(height: 70.h),
        BlocListener<
          LoginUserWithEmailAndPasswordCubit,
          LogInUserWithEmailAndPasswordState
        >(
          listener: (context, state) {
            if (state is LogInUserWithEmailAndPasswordLoading) {
              CustomLoadingAnimation.buildLoadingIndicator(context);
            } else if (state is LogInUserWithEmailAndPasswordFailure) {
              GoRouter.of(context).pop();
              Fluttertoast.showToast(
                msg: state.errMessage,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else if (state is LogInUserWithEmailAndPasswordSuccess) {
              GoRouter.of(context).pop();
              if (getIt.get<FirebaseAuth>().currentUser != null &&
                  getIt.get<FirebaseAuth>().currentUser!.emailVerified) {
                GoRouter.of(context).go(AppRouter.kHomeView);
              } else {
                GoRouter.of(context).push(AppRouter.kEmailVerifyView);
              }
            }
          },
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                BlocProvider.of<LoginUserWithEmailAndPasswordCubit>(
                  context,
                ).logInUserWithEmailAndPassword(
                  UserData(email: email, password: password),
                );
              }
            },
            child: SizedBox(
              height: 48.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  StringsManager.login.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  _onSavedEmail(email) {
    this.email = email;
  }

  _onSavedPassword(password) {
    this.password = password;
  }
}
