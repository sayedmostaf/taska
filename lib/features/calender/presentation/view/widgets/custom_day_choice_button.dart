import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';

class CustomDayChoiceButton extends StatelessWidget {
  const CustomDayChoiceButton({
    super.key,
    required this.isSelected,
    required this.text,
    this.onTap,
  });
  final bool isSelected;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isSelected ? null : onTap,
          borderRadius: BorderRadius.circular(5),
          hoverColor: Colors.red,
          child: Container(
            padding: EdgeInsets.all(2),
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected
                  ? ColorManager.primaryColor
                  : Colors.transparent,
              border: isSelected
                  ? null
                  : Border.all(color: Colors.grey, width: 2),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
