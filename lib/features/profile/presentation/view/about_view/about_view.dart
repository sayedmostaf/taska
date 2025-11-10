import 'package:flutter/material.dart';
import 'package:taska/features/profile/presentation/view/about_view/widgets/about_view_body.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const AboutViewBody(),
    );
  }
}
