import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/constants/icon_constants.dart';
import '../../../utils/size_utils.dart';
import '../landing/page_state_machine.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Common Variables
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  checkUserStatus() async {
    //AuthService.logout();
    await navigationPage();
  }

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, checkUserStatus);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(body: SafeArea(child: splashBody()));
  }

  Widget splashBody() {
    return Container(
        padding: EdgeInsets.all(SizeUtils.get(20)),
        alignment: Alignment.center,
        child: Image.asset(IconConstants.olmLogo));
  }

  Future<void> navigationPage() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PageStateMachine()),
        (Route<dynamic> route) => false);
  }
}
