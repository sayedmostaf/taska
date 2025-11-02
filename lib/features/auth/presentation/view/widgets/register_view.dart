import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/auth/presentation/view/widgets/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final GlobalKey<FormState> formKey;
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
          StringsManager.register.tr(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 30.h),
        RegisterForm(
          formKey: formKey,
          onSavedName: onSavedName,
          onSavedEmail: onSavedEmail,
          onSavedPassword: onSavedPassword,
        ),
        SizedBox(height: 40.h),
        ElevatedButton(
          onPressed: () {
            formKey.currentState!.validate();
          },
          child: SizedBox(
            height: 48.h,
            width: double.infinity,
            child: Center(
              child: Text(
                StringsManager.register.tr(),
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  onSavedEmail(email) {}
  onSavedName(name) {}
  onSavedPassword(password) {}
}
