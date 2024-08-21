import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  LoadingDialog({this.callerFunction, this.onErrorCallBack}) {
    _loadingDialog();
  }

  final Future<void> Function()? callerFunction;
  final void Function(String? error)? onErrorCallBack;

  void _loadingDialog() async {
    Get.dialog(
      LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          child: Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }),
      barrierDismissible: false,
    );
    if (callerFunction != null) {
      try {
        await callerFunction!();
        Get.back();
      } catch (e) {
        Get.back();
        if (onErrorCallBack != null) {
          onErrorCallBack!(e.toString());
        }
      }
    } else {
      Get.back();
    }
  }
}
