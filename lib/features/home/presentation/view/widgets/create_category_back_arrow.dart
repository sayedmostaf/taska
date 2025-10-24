import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';

class CreateCategoryBackArrow extends StatelessWidget {
  const CreateCategoryBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            CustomLoadingAnimation.buildLoadingIndicator(context);
            await Future.delayed(Duration(milliseconds: 1000));
            if (context.mounted) {
              GoRouter.of(context).pop();
              GoRouter.of(context).pop();
            }
          },
          alignment: Alignment.centerLeft,
          icon: Icon(CustomIcons.back_icon),
        ),
        Spacer(),
      ],
    );
  }
}
