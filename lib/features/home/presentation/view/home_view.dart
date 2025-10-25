import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/calender/presentation/view/calendar_view.dart';
import 'package:taska/features/focus/presentation/view/focus_view.dart';
import 'package:taska/features/home/presentation/view/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:taska/features/home/presentation/view/widgets/custom_floating_action_button.dart';
import 'package:taska/features/index/presentation/view/index_view/index_view.dart';
import 'package:taska/features/profile/presentation/view/profile_view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;
  final List<Widget> _children = [
    IndexView(),
    CalendarView(),
    FocusView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[activeIndex],
      floatingActionButton: CustomFloatingActionButton(),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AnimatedBottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      splashRadius: 0,
      splashColor: Colors.transparent,
      itemCount: 4,
      activeIndex: activeIndex,
      gapLocation: GapLocation.center,
      onTap: (index) {
        setState(() {
          activeIndex = index;
        });
      },
      height: 65.h,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ColorManager.greyColor
          : ColorManager.primaryColor,
      tabBuilder: (int index, bool isActive) {
        return CustomBottomNavigationBarItem(index: index, isActive: isActive);
      },
    );
  }
}
