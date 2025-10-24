import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taska/core/utils/assets_manager.dart';

class CustomErrorImage extends StatelessWidget {
  const CustomErrorImage({super.key, this.width, this.height});
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsManager.checklist,
      width: width ?? 50.w,
      height: height ?? 50.h,
    );
  }
}
