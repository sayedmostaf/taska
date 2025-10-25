import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_simple_app_bar.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/focus/presentation/view/widgets/counter_timer_widget.dart';
import 'package:taska/features/focus/presentation/view/widgets/focus_view_body.dart';

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusViewBody();
  }
}
