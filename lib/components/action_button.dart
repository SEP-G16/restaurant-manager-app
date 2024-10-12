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
    this.borderWidth = 1.0,
    this.fontWeight,
    this.outlineModeHoverColour,
    this.outlineModeTextColour,
    this.isDisabled = false,
  });

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
  Color? outlineModeHoverColour;
  Color? outlineModeTextColour;
  bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isDisabled
                ? Colors.black.withOpacity(0.6)
                : outlineMode
                    ? borderColour ?? ColourConstants.gamboge
                    : Colors.transparent,
            width: borderWidth,
            strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: height ?? 60,
      width: width ?? 150,
      child: Stack(
        children: [
          Material(
            color: outlineMode
                ? Colors.transparent
                : btnColor ?? ColourConstants.gamboge,
            borderRadius: BorderRadius.circular(10.0),
            child: isDisabled
                ? Center(
                    child: Text(
                      btnText,
                      textAlign: TextAlign.center,
                      style: TextConstants.subTextStyle(
                        color: isDisabled
                            ? Colors.black.withOpacity(0.6)
                            : outlineMode
                                ? outlineModeTextColour ??
                                    borderColour ??
                                    ColourConstants.gamboge
                                : textColor ?? ColourConstants.chineseBlack,
                        fontSize: fontSize ?? 22,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: onTap,
                    overlayColor: WidgetStateProperty.resolveWith(
                      (_) => outlineMode
                          ? outlineModeHoverColour ??
                              ColourConstants.gamboge.withOpacity(0.1)
                          : ColourConstants.chineseBlack.withOpacity(
                              0.1,
                            ),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Center(
                      child: Text(
                        btnText,
                        textAlign: TextAlign.center,
                        style: TextConstants.subTextStyle(
                          color: outlineMode
                              ? outlineModeTextColour ??
                                  borderColour ??
                                  ColourConstants.gamboge
                              : textColor ?? ColourConstants.chineseBlack,
                          fontSize: fontSize ?? 22,
                          fontWeight: fontWeight ?? FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
          Visibility(
            visible: isDisabled,
            child: Container(
              color: Colors.black54.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
