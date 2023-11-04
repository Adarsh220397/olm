import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/home/home_screen.dart';
import 'package:olm/src/presentation/widgets/button_widget.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/size_utils.dart';

import '../../../utils/constants/font_constants.dart';
import '../../../utils/constants/icon_constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(body: SafeArea(child: onBoardingBody()));
  }

  Widget onBoardingBody() {
    return Stack(fit: StackFit.expand, children: [
      firstPosterLogo(),
      // BackdropFilter(
      //   filter: ImageFilter.blur(
      //       sigmaX: 1,
      //       sigmaY: 1),
      //   child: Container(
      //     color: Colors.black
      //         .withOpacity(0),
      //   ),
      // ),
      Container(
        color: Colors.white.withOpacity(0.7),
        width: double.infinity,
        height: double.infinity,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Welcome To',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.textColor,
                          fontSize: 24)),
                  Text('ONLY MUTTON',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.textColor,
                          fontSize: 34)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'We bring 100 % natural and \n hormone free halal meet from the \n farm to your door.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.textColor,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 327,
                    child: ElevatedButton(
                        child: const Text('Get Started'),
                        onPressed: onClick,
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.appButtonColor,

                          // side: BorderSide(
                          //   width: 3,
                          // ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          // padding:
                          //     EdgeInsets.all(20)
                        )),
                  ),
                ],
              )
            ],
          ),
        ],
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

  Widget firstPosterLogo() {
    return Image.asset(
      IconConstants.onboardingLogo,
      fit: BoxFit.cover,
    );
  }

  Widget image(String path) {
    return Image.asset(path);
  }

  Widget buildImage(String path) => Column(children: [
        Container(
          padding: EdgeInsets.only(top: SizeUtils.get(2)),
          height: SizeUtils.get(22),
          child: firstPosterLogo(),
        ),
        SizedBox(height: SizeUtils.get(5)),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: SizeUtils.get(43),
            width: SizeUtils.screenWidth,
            child: image(path),
          ),
        )
      ]);

  // DotsDecorator getDotDecoration() => DotsDecorator(
  //       color: const Color(0xFFBDBDBD),
  //       activeColor: ColorConstants.appColor,
  //       size: Size(SizeUtils.get(2.5), SizeUtils.get(2.5)),
  //       activeSize: Size(SizeUtils.get(5), SizeUtils.get(2.5)),
  //       activeShape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(SizeUtils.get(5)),
  //       ),
  //     );

  // PageDecoration getPageDecoration() => PageDecoration(
  //       titleTextStyle: themeData.textTheme.headline5!
  //           .copyWith(fontWeight: FontWeight.bold),
  //       bodyTextStyle: themeData.textTheme.titleLarge!.copyWith(
  //         fontWeight: FontWeight.normal,
  //         color: ColorConstants.textColor,
  //       ),
  //       imagePadding: EdgeInsets.all(SizeUtils.get(2)),
  //     );
}
