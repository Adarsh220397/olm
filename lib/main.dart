import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/home/splash_screen.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/size_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        unselectedWidgetColor: Colors.black,
      ),
      // theme: ThemeData(
      //   colorScheme: const ColorScheme.light(
      //     primary: ColorConstants.appButtonColor,
      //   ),
      //   // fontFamily: FontConstants.roboto,
      //   dialogBackgroundColor: Colors.white,
      //   primaryColor: ColorConstants.appButtonColor,
      //   scaffoldBackgroundColor: Colors.black,
      //   brightness: Brightness.dark,
      //   scrollbarTheme: ScrollbarThemeData(
      //     thumbColor: MaterialStateProperty.all(ColorConstants.appButtonColor),
      //     minThumbLength: SizeUtils.get(2),
      //     radius: Radius.circular(SizeUtils.get(1)),
      //     thickness: MaterialStateProperty.all(SizeUtils.get(0.5)),
      //   ),
      // ),
      home: SplashScreen(),
    );
  }
}
