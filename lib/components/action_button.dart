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
    this.outlineMode = false,
    this.borderColour,
    this.borderWidth = 0.0,
    this.fontWeight,
  }){
    assert(outlineMode ? borderColour != null && borderWidth !=  0.0 : true, "outlineMode cannot be true without borderColour");
  }

  final String btnText;
  final Function() onTap;
  double? height;
  double? width;
  Color? btnColor;
  Color? textColor;
  double? fontSize;
  bool outlineMode;
  Color? borderColour;
  double borderWidth;
  FontWeight? fontWeight;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: outlineMode ? borderColour! : Colors.transparent, width: borderWidth, strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: height ?? 60,
      width: width ?? 150,
      child: Material(
        color: btnColor ?? ColourConstants.gamboge,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStateProperty.resolveWith(
            (_) => ColourConstants.chineseBlack.withOpacity(
              0.1,
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextConstants.subTextStyle(
                color: textColor ?? ColourConstants.chineseBlack,
                fontSize: fontSize ?? 28,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
