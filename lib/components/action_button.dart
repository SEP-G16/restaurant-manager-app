import 'package:flutter/material.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    required this.btnText,
    required this.onTap,
    this.height,
    this.width,
    this.btnColor,
    this.textColor,
    this.fontSize,
    this.borderColor,
  });

  final String btnText;
  final Function() onTap;
  double? height;
  double? width;
  Color? btnColor;
  Color? textColor;
  double? fontSize;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0), // Adds ripple effect within the border
      child: Container(
        height: height ?? 60,
        width: width ?? 150,
        decoration: BoxDecoration(
          color: btnColor ?? ColourConstants.gamboge,
          borderRadius: BorderRadius.circular(10.0),
          border: borderColor != null
              ? Border.all(
            color: borderColor!,
            width: 2.0,
          )
              : null, // No border if borderColor is null
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextConstants.subTextStyle(
              color: textColor ?? ColourConstants.chineseBlack,
              fontSize: fontSize ?? 28,
            ),
          ),
        ),
      ),
    );
  }
}
