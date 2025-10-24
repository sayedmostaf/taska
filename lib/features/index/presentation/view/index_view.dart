import 'package:flutter/material.dart';
import 'package:taska/features/index/presentation/view/widgets/index_view_body.dart';

class IndexView extends StatelessWidget {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return IndexViewBody();
  }
}

enum TaskState { completed, uncompleted, active }
