import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';

class CreateCategoryBackArrow extends StatelessWidget {
  const CreateCategoryBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            GoRouter.of(context).pop();
          },
          alignment: Alignment.centerLeft,
          icon: Icon(CustomIcons.back_icon),
        ),
        Spacer(),
      ],
    );
  }
}
