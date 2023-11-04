import 'package:flutter/cupertino.dart';

class SizeUtils {
  static double _widthMultiplier = 0;
  static double _heightMultiplier = 0;
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void init(BoxConstraints boxConstraints, Orientation orientation) {
    screenWidth = boxConstraints.maxWidth;
    screenHeight = boxConstraints.maxHeight;

    print("Screen Width " + screenWidth.toString());
    print("Screen Width " + screenHeight.toString());

    if (orientation == Orientation.portrait) {
      _widthMultiplier = boxConstraints.maxWidth / 100;
      _heightMultiplier = boxConstraints.maxHeight / 100;
    } else {
      _widthMultiplier = boxConstraints.maxHeight / 100;
      _heightMultiplier = boxConstraints.maxWidth / 100;
    }
  }

  static double get(double size) {
    return _widthMultiplier * size;
  }
}
