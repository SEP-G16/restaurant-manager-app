import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/order_screen/order_data_controller.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/add_reservation_tab_view_data_controller.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/view_reservations_tab_view_data_controller.dart';
import 'package:restaurant_manager/controller/data/table/table_data_controller.dart';
import 'package:restaurant_manager/controller/network/inventory_network_controller.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/controller/network/table_data_network_controller.dart';
import 'package:restaurant_manager/controller/network/web-socket-controller.dart';
import 'package:restaurant_manager/controller/views/drawer_state_controller.dart';
import 'package:restaurant_manager/controller/views/orders_screen/order_screen_main_state_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_date_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_drop_down_controller.dart';
import 'package:restaurant_manager/controller/views/view_inventory_screen/inventory_screen_state_controller.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';

import 'controller/data/inventory_screen/inventory_data_controller.dart';

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
      Get.put(AddReservationTabViewDateController());
      Get.put(AddReservationTabViewDropDownController());
      Get.put(AddReservationTabViewController());

      await Get.putAsync(() => ViewReservationsTabViewDataController.create());

      await Get.putAsync(() => OrderDataController.create());
      Get.put(OrderScreenMainStateController());

      Get.put(InventoryNetworkController());
      await Get.putAsync(() => InventoryDataController.create());
      Get.put(InventoryScreenStateController());

      Get.put(TableDataNetworkController());
      await Get.putAsync(() => TableDataController.create());

      Get.put(DrawerStateController());

      // _initialized = true;
    }catch(e){
      print('########################-------------------------Error occurred while initialising controllers! : $e -------------------------########################');
      _initialized = false;
      rethrow;
    }
  }
}