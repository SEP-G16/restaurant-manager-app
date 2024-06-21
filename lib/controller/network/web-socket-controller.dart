import 'package:get/get.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:restaurant_manager/constants.dart';

class WebSocketController extends GetxController{
  static WebSocketController instance = Get.find();

  late SIO.Socket _socket;

  WebSocketController._();

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController () async {
    try{
      _socket = SIO.io('${baseUrl}', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      _socket.onConnect((_){
        print('Connected');
      });
      _socket.connect();

      _socket.on('showAlert', (_) {
        print('Executed');
        WelcomeScreenController welcomeScreenController = WelcomeScreenController.instance;
        welcomeScreenController.onHelpRequest();
      });
    }catch(e){
      print('Error establishing websocket connection.');
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