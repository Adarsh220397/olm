import 'dart:async';
import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/home/home_screen.dart';
import 'package:olm/src/presentation/screens/landing/onboarding_page.dart';

class PageStateMachine extends StatefulWidget {
  const PageStateMachine({Key? key}) : super(key: key);

  @override
  State<PageStateMachine> createState() => _PageStateMachineState();
}

class _PageStateMachineState extends State<PageStateMachine> {
  late ThemeData themeData;

  String path = 'splash';
  @override
  void initState() {
    super.initState();
    startTime();
  }

  fetchData() async {
    // Startup startup = Startup();
    // path = await startup.getStartupPage();
    gotoScreen('splash');
  }

  startTime() async {
    var _duration = const Duration(milliseconds: 50);
    return Timer(_duration, fetchData);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Container();
  }

  void gotoScreen(String path) {
    switch (path) {
      case 'splash':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingPage()),
            (Route<dynamic> route) => false);
        break;

      case 'Home':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false);
        break;
    }
  }
}
