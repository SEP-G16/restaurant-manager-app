import 'package:get/get.dart';
import 'package:restaurant_manager/controller/network/web-socket-controller.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';

class ControllerInitializer{
  static bool _initialized = false;

  static bool get initialized => _initialized;

  static Future<void> initAllControllers() async {
    try{
      await Get.putAsync(() => WebSocketController.create());

      Get.put(WelcomeScreenController());
      _initialized = true;
    }catch(e){
      print('Error occurred while initialising controllers!');
      _initialized = false;
      rethrow;
    }
  }
}