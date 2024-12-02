import 'package:flutter/material.dart';
import 'package:hopewater/src/base/view/home/view/home_view.dart';
import 'package:hopewater/src/base/view/profile/view/profile_view.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class BaseView extends StatefulWidget {
  static String route = "/bottomnavigation";
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;
  List<Widget> widgetList = [
    const HomeViewScreen(),
    const ProfileSettingView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: R.colors.primraryTextColor,
        selectedItemColor: R.colors.splashColor,
        selectedLabelStyle: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 8.sp,
            decoration: TextDecoration.none,
            color: R.colors.primraryTextColor),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          commonBottomNavigation(Icons.home, 'Home'),
          commonBottomNavigation(Icons.settings, 'Profile')
        ],
      ),
    );
  }

  BottomNavigationBarItem commonBottomNavigation(IconData icons, String text) {
    return BottomNavigationBarItem(
      activeIcon: Icon(
        icons,
        size: 35,
        color: R.colors.splashColor,
      ),
      icon: Icon(icons, size: 35, color: R.colors.lightGray),
      label: (text),
    );
  }
}
