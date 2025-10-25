import 'package:flutter/material.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditTaskViewBody());
  }
}
