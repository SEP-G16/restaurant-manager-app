import 'package:get/get.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';

class WelcomeScreenController extends GetxController {
  static WelcomeScreenController instance = Get.find();

  void onHelpRequest() {
    MessageDialogBox(message: 'A customer needs attention', fontSize: 18, btnOnPressed: (){Get.back();});
  }
}
