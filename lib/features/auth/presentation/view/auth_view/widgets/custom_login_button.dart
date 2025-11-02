import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taska/core/utils/color_manager.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    super.key,
    required this.asset,
    required this.text,
    this.onPressed,
  });
  final String asset, text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStatePropertyAll(
            BorderSide(color: ColorManager.primaryColor),
          ),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          elevation: MaterialStatePropertyAll(0),
          overlayColor: MaterialStatePropertyAll(
            ColorManager.primaryColor.withAlpha(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 10),
            SvgPicture.asset(asset, width: 24.w, height: 24.h),
            Spacer(flex: 1),
            Text(text, style: Theme.of(context).textTheme.headlineSmall),
            const Spacer(flex: 10),
          ],
        ),
      ),
    );
  }
}
