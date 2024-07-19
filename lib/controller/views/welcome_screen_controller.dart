import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';

class WelcomeScreenController extends GetxController {
  static WelcomeScreenController instance = Get.find();

  void onHelpRequest({var data}) {
    if (data == null) {
      print('Null Data');
      MessageDialogBox(
        message: 'An Unexpected Error Occurred',
        btnOnPressed: () {
          Get.back();
        },
      );
    } else {
      Map<String, dynamic> dataMap = jsonDecode(data);
      MessageDialogBox(
        message: 'A customer at table ${dataMap['tableNo']!} needs attention',
        fontSize: 18,
        btnOnPressed: () {
          Get.back();
        },
      );
    }
  }
}
