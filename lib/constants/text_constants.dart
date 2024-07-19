import 'package:flutter/material.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';

class TextConstants {

  TextConstants._();

  static mainTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
        fontSize: fontSize ?? 30.0,
        color: color ?? ColourConstants.chineseBlack,
        fontWeight: FontWeight.w600,
        fontFamily: 'Altone Trial');
  }

  static subTextStyle({double? fontSize, FontWeight? fontWeight, Color? color}){
    return TextStyle(
        fontSize: fontSize ?? 20.0,
        color: color ?? ColourConstants.chineseBlack,
        fontWeight: FontWeight.w600,
        fontFamily: 'Altone Trial'
    );
  }

}
