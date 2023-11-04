import 'package:flutter/material.dart';
import 'package:olm/src/utils/constants/color_constants.dart';

abstract class FontConstants {
  static const String roboto = "Roboto";
  static const String montserrat = "Montserrat";
}

abstract class FontStyleConstants {
  static const TextStyle textThemeHeadline6 = TextStyle(
      color: ColorConstants.appButtonColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15);

  static const TextStyle textThemeHeadline5 = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0);
  static const TextStyle textThemeHeadline4 = TextStyle(
      color: Colors.white,
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25);
  static const TextStyle textThemeHeadline3 = TextStyle(
      color: Colors.white,
      fontSize: 48,
      fontWeight: FontWeight.w400,
      letterSpacing: 0);
  static const TextStyle textThemeHeadline2 = TextStyle(
      color: Colors.white,
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5);
  static const TextStyle textThemeHeadline1 = TextStyle(
      color: Colors.white,
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  static const TextStyle textThemeSubtitle1 = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15);
  static const TextStyle textThemeSubtitle2 = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1);
  static const TextStyle textThemeBody1 = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5);
  static const TextStyle textThemeBody2 = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25);
  static const TextStyle textThemeButton = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0);
}
