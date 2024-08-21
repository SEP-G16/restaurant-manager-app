import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/add_reservation_tab_view_data_controller.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/view_reservations_tab_view_data_controller.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/controller/network/web-socket-controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';

class ControllerInitializer{
  static bool _initialized = false;

  static bool get initialized => _initialized;

  static Future<void> initAllControllers() async {
    try{
      await Get.putAsync(() => WebSocketController.create());

      Get.put(WelcomeScreenController());

      //Reservations
      Get.put(ReservationNetworkController());
      await Get.putAsync(() => AddReservationTabViewDataController.create());
      Get.put(AddReservationTabViewController());
      await Get.putAsync(() => ViewReservationsTabViewDataController.create());
      _initialized = true;
    }catch(e){
      print('Error occurred while initialising controllers!');
      _initialized = false;
      rethrow;
    }
  }
}