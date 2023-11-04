import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/home/home_screen.dart';
import 'package:olm/src/presentation/widgets/button_widget.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/size_utils.dart';

import '../../../utils/constants/font_constants.dart';
import '../../../utils/constants/icon_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(body: SafeArea(child: onBoardingBody()));
  }

  Widget onBoardingBody() {
    return Stack(fit: StackFit.expand, children: [
      Container(
        color: Colors.white.withOpacity(0.7),
        width: double.infinity,
        height: double.infinity,
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SearchScreen',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: FontStyleConstants.textThemeSubtitle2.copyWith(
                  color: ColorConstants.textColor, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ButtonWidget(
                bFullContainerButton: true,
                text: 'Get Started',
                onClicked: onClick,
              ),
            )
          ],
        ),
      )
    ]);
  }

  onClick() async {
    print('---on click---');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
