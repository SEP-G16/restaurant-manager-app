import 'package:get/get.dart';
import 'package:restaurant_manager/constants/order_constants.dart';
import 'package:restaurant_manager/exception/network_exception.dart';

class OrderNetworkController extends GetxController {
  static OrderNetworkController get instance =>
      Get.isRegistered<OrderNetworkController>()
          ? Get.find<OrderNetworkController>()
          : Get.put(OrderNetworkController());

  //fetch orders from "today" only & fetch orders with statuses
  Future<List<Map<String, dynamic>>> fetchOrders() async {
    try {
      // simulate network delay
      await Future.delayed(Duration(seconds: 1));
      // fetch orders
      List<Map<String, dynamic>> dataList = OrderConstants.orders.map((order) => order.toMap()).toList();
      return dataList;
    } catch (e) {
      throw NetworkException(message: 'Failed to fetch orders: $e');
    }
  }

  void updateOrderStatus() {
    //update order status
  }
}
