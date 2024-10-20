import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/controller/data/order_screen/order_data_controller.dart';
import 'package:restaurant_manager/controller/views/web_socket_dialog_controller.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';
import 'package:restaurant_manager/enum/role.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:restaurant_manager/constants/network_constants.dart';

class WebSocketController extends GetxController {
  static WebSocketController instance = Get.find();

  late SIO.Socket _socket;

  WebSocketController._();

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      _socket = SIO.io('${NetworkConstants.websocketUrl}', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'path': '/ws',
      });

      _socket.onConnect((_) {
        print('Connected');
      });
      _socket.connect();

      _socket.on('readHelpRequest', (data) {
        if (AuthController.instance.hasRole([
          Role.ROLE_ADMIN,
          Role.ROLE_FRONT_DESK,
          Role.ROLE_RESTAURANT_MANAGER
        ])) {
          WelcomeScreenController welcomeScreenController =
              WelcomeScreenController.instance;
          welcomeScreenController.onHelpRequest(data: data);
        }
      });

      _socket.on('readOrderAdded', (data) {
        if(AuthController.instance.hasRole([Role.ROLE_ADMIN, Role.ROLE_CHEF])){
          OrderDataController.instance.reInitController();
        }
      });

      _socket.on('readReadyToPay', (data) {
        print('Showed');
        if(AuthController.instance.hasRole([Role.ROLE_ADMIN, Role.ROLE_RESTAURANT_MANAGER, Role.ROLE_FRONT_DESK])){
          WebSocketDialogController.showReadyToPayDialog(jsonDecode(data));
        }
      });
    } catch (e) {
      print('Error establishing websocket connection.');
      rethrow;
    }
  }

  void sendWSRequest({required String message, Map<String, dynamic>? data}) {
    try {
      _socket.emit(
        message,
        jsonEncode(data),
      );
    } catch (e) {
      print('Error sending help request');
      rethrow;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _socket.connect();
    super.onInit();
  }
}
