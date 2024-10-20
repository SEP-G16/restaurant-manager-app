import 'package:get/get.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';

class WebSocketDialogController {
  WebSocketDialogController._();

  static void showReadyToPayDialog(Map<String, dynamic> dataMap) {
    MessageDialogBox(
      message:
          'A Customer at Table ${dataMap['tableNo']} is ready to pay their bill',
      btnOnPressed: () {
        Get.back();
      },
    );
  }
}
