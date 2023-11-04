import 'package:flutter/material.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/size_utils.dart';

buttonThemeDark() {
  return ButtonThemeData(
      padding: const EdgeInsets.all(15.0),
      textTheme: ButtonTextTheme.primary,
      buttonColor: ColorConstants.appColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
}

ButtonStyle elevatedButtonTheme() {
  return ElevatedButton.styleFrom(
    onSurface: ColorConstants.appColor,
    primary: ColorConstants.appColor,
    minimumSize: Size(SizeUtils.screenWidth / 2, SizeUtils.get(9)),
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(3)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(SizeUtils.get(2))),
    ),
  );
}

ButtonStyle disabledButtonTheme() {
  return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
          Size(SizeUtils.screenWidth / 2, SizeUtils.get(9))),
      padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: SizeUtils.get(3))),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SizeUtils.get(2))),
      )),
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return ColorConstants.buttomDisabledColor;
        }

        return ColorConstants.appColor;
      }));
}
