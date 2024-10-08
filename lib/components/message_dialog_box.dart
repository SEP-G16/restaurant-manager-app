import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDialogBox {
  final String message;
  Color borderColor;
  double borderRadius;
  double? height;
  double? width;
  double fontSize;
  bool barrierDismissible;
  Color backgroundColor;
  Color textColor;
  final Function() btnOnPressed;
  String btnText;

  MessageDialogBox({
    required this.message,
    this.borderColor = Colors.indigoAccent,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 10.0,
    this.height,
    this.width = 200.0,
    this.fontSize = 30,
    this.barrierDismissible = true,
    required this.btnOnPressed,
    this.btnText = 'OK',
  }) {
    Get.dialog(
        Dialog(
          child: Container(
            padding: EdgeInsets.all(10.0),
            height: height,
            width: width,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                ),
              ), TextButton(onPressed: btnOnPressed, child: Text(btnText))]
            ),
          ),
        ),
        barrierDismissible: barrierDismissible);
  }
}
