import 'package:get/get.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';
import 'package:restaurant_manager/controller/network/order_network_controller.dart';
import 'package:restaurant_manager/enum/order_status.dart';
import 'package:restaurant_manager/exception/network_exception.dart';

import '../../../enum/order_item_status.dart';
import '../../../model/order.dart';
import '../../../model/order_item.dart';

class OrderDataController extends GetxController {
  static OrderDataController instance = Get.find();

  List<Order> _orderList = <Order>[];
  RxList<Order> listenableOrderList = <Order>[].obs;
  List<Order> get orderList => _orderList;

  OrderNetworkController _onc = OrderNetworkController.instance;

  OrderDataController._();

  static Future<OrderDataController> create() async {
    OrderDataController controller = OrderDataController._();
    await controller._fetchOrders();
    return controller;
  }

  Future<void> reInitController() async {
    _orderList.clear();
    listenableOrderList.clear();
    await _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      List<Map<String, dynamic>> orderList = await _onc.fetchOrders();
      _orderList =
          orderList.map((orderMap) => Order.fromMap(orderMap)).toList();
      listenableOrderList.assignAll(_orderList);
    } on NetworkException catch (e) {
      // MessageDialogBox(message: 'A network error occurred!', btnOnPressed: () => Get.back());
      print(e.toString());
    } on FormatException catch (e) {
      // MessageDialogBox(message: 'Unable to format data!', btnOnPressed: () => Get.back());
      print(e.toString());
    } on Exception catch (e) {
      // MessageDialogBox(message: 'An unexpected error occurred!', btnOnPressed: () => Get.back());
      print(e.toString());
    }
  }

  void updateOrderStatus() {
    //update order status
  }

  Future<void> acceptPendingOrderItem(int orderId, int orderItemId) async {
    //Do a network call to update the order item status

    List<OrderItem> originalItemList = orderList
        .where((order) => order.id == orderId)
        .toList()
        .first
        .orderItems;
    List<OrderItem> updatedItemList = originalItemList.map((orderItem) {
      if (orderItem.id == orderItemId) {
        return orderItem.copyWith(status: OrderItemStatus.Processing);
      }
      return orderItem;
    }).toList();



    List<Order> updatedOrderList = orderList.map((order) {
      if (order.id == orderId) {
        return order.copyWith(
          orderItems: updatedItemList,
          status: OrderStatus.Processing,
        );
      }
      return order;
    }).toList();
    _orderList = updatedOrderList;
    listenableOrderList.assignAll(_orderList);
  }

  Future<void> rejectPendingOrderItem(int orderId, int orderItemId) async {
    //Do a network call to reject pending order item

    List<OrderItem> originalItemList = orderList
        .where((order) => order.id == orderId)
        .toList()
        .first
        .orderItems;
    List<OrderItem> updatedItemList = originalItemList
        .where((orderItem) => orderItem.id != orderItemId)
        .toList();

    if(updatedItemList.isNotEmpty)
      {
        List<Order> updatedOrderList = orderList.map((order) {
          if (order.id == orderId) {
            return order.copyWith(orderItems: updatedItemList);
          }
          return order;
        }).toList();
        _orderList = updatedOrderList;
        listenableOrderList.assignAll(_orderList);
      }
    else
      {
        List<Order> updatedOrderList = orderList.where((order) => order.id != orderId).toList();
        _orderList = updatedOrderList;
        listenableOrderList.assignAll(_orderList);
      }
  }

  Future<void> completeProcessingOrderItem(int orderId, int orderItemId) async {
    //Do a network call to complete processing order item

    List<OrderItem> originalItemList = orderList
        .where((order) => order.id == orderId)
        .toList()
        .first
        .orderItems;
    List<OrderItem> updatedItemList = originalItemList
        .where((orderItem) => orderItem.id != orderItemId)
        .toList();

    if(updatedItemList.isNotEmpty)
    {
      List<Order> updatedOrderList = orderList.map((order) {
        if (order.id == orderId) {
          return order.copyWith(orderItems: updatedItemList);
        }
        return order;
      }).toList();
      _orderList = updatedOrderList;
      listenableOrderList.assignAll(_orderList);
    }
    else
    {
      List<Order> updatedOrderList = orderList.where((order) => order.id != orderId).toList();
      _orderList = updatedOrderList;
      listenableOrderList.assignAll(_orderList);
    }
  }
}
