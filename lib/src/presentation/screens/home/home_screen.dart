import 'dart:async';

import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/home/base_screen.dart';
import 'package:olm/src/presentation/screens/home/order_screen.dart';
import 'package:olm/src/presentation/screens/home/profile_screen.dart';
import 'package:olm/src/presentation/screens/home/search_screen.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/font_constants.dart';
import '../../../utils/constants/icon_constants.dart';
import '../../../utils/size_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Common Variables
  late ThemeData themeData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BaseScreen(),
    const SearchScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: ColorConstants.appButtonColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          customBottomNavigationBarItem(
            icon: IconWithDot(
              icon: Icons.home,
              selected: _currentIndex == 0,
            ),
            label: _currentIndex == 0 ? '' : 'Home',
          ),
          customBottomNavigationBarItem(
            icon: IconWithDot(
              icon: Icons.search,
              selected: _currentIndex == 1,
            ),
            label: _currentIndex == 1 ? '' : 'Search',
          ),
          customBottomNavigationBarItem(
            icon: IconWithDot(
              icon: Icons.shopping_cart,
              selected: _currentIndex == 2,
            ),
            label: _currentIndex == 2 ? '' : 'Order',
          ),
          customBottomNavigationBarItem(
            icon: IconWithDot(
              icon: Icons.person,
              selected: _currentIndex == 3,
            ),
            label: _currentIndex == 3 ? '' : 'Profile',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem customBottomNavigationBarItem({
    required Widget icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}

class IconWithDot extends StatelessWidget {
  final IconData icon;
  final bool selected;

  IconWithDot({
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 40,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24, // Set a fixed size for the icon
                ),
                const SizedBox(
                  height: 7,
                ),
                if (selected) CircleDot(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CircleDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstants.appButtonColor,
      ),
    );
  }
}
