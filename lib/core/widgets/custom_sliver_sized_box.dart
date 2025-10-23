import 'package:flutter/widgets.dart';

class CustomSliverSizedBox extends StatelessWidget {
  const CustomSliverSizedBox({super.key, this.width, this.height});
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height, width: width),
    );
  }
}
