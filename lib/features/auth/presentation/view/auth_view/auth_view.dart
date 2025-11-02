import 'package:flutter/material.dart';
import 'package:taska/features/auth/presentation/view/auth_view/widgets/auth_view_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: AuthViewBody(),
      ),
    );
  }
}
