import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.onSavedName,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });
  final GlobalKey<FormState> formKey;
  final Function(String?) onSavedName, onSavedEmail, onSavedPassword;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final GlobalKey<FormFieldState<String>> _confirmPassword;
  String password = '';
  @override
  void initState() {
    super.initState();
    _confirmPassword = GlobalKey<FormFieldState<String>>();
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.name.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: StringsManager.enterName.tr(),
            ),
            validator: _buildNameValidation,
            onSaved: widget.onSavedName,
          ),
          SizedBox(height: 20.h),
          Text(
            StringsManager.email.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: StringsManager.enterEmail.tr(),
              suffixIcon: Icon(Icons.check_circle, color: Colors.green),
            ),
            validator: _buildEmailValidation,
            onSaved: widget.onSavedEmail,
          ),
          SizedBox(height: 20.h),
          Text(
            StringsManager.password.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: StringsManager.enterPassword.tr(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.remove_red_eye,
                ),
              ),
            ),
            obscureText: obscure,
            validator: _buildPasswordValidation,
            onSaved: widget.onSavedPassword,
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(height: 20.h),
          Text(
            StringsManager.confirmPassword.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),
          TextFormField(
            key: _confirmPassword,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: StringsManager.enterPassword.tr(),
            ),
            obscureText: obscure,
            validator: _buildConfirmPasswordValidation,
            onChanged: (value) {
              _confirmPassword.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }

  String? _buildNameValidation(value) {
    if (value == null || value.length < 3) {
      return StringsManager.nameValidation.tr();
    }
    return null;
  }

  String? _buildEmailValidation(value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return StringsManager.emailValidation.tr();
    }
    return null;
  }

  String? _buildPasswordValidation(value) {
    if (value == null || value.isEmpty) {
      return StringsManager.passwordValidation.tr();
    }
    String validationMessage = _validatePassword(value);
    if (validationMessage.isNotEmpty) {
      return validationMessage;
    }
    return null;
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

  String? _buildConfirmPasswordValidation(value) {
    if (value != password) {
      return StringsManager.confirmPasswordValidation.tr();
    }
    return null;
  }
}
