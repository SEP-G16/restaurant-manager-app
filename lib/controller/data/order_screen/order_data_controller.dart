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
    await _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    List<Map<String, dynamic>> orderList = await _onc.getAllOrders();
    _orderList = orderList.map((orderMap) => Order.fromMap(orderMap)).toList();
    listenableOrderList.assignAll(_orderList);
  }

  Future<void> _updateOrderItemStatus(int orderId, int orderItemId, OrderItemStatus status) async {
    Map<String, dynamic> updatedOrderMap = await _onc.updateOrderItemStatus(
      orderId: orderId,
      orderItemId: orderItemId,
      orderItemStatus: status,
    );

    List<OrderItem> originalItemList = orderList
        .where((order) => order.id == orderId)
        .toList()
        .first
        .orderItems;

    List<OrderItem> updatedItemList = originalItemList.map((orderItem) {
      if (orderItem.id == orderItemId) {
        return orderItem.copyWith(status: status);
      }
      return orderItem;
    }).toList();

    List<Order> updatedOrderList = orderList.map((order) {
      if (order.id == orderId) {
        return order.copyWith(
          orderItems: updatedItemList,
          status: OrderStatus.fromString(updatedOrderMap['status']),
        );
      }
      return order;
    }).toList();
    _orderList = updatedOrderList;
    listenableOrderList.assignAll(_orderList);
  }

  Future<void> acceptPendingOrderItem(int orderId, int orderItemId) async {
    await _updateOrderItemStatus(orderId, orderItemId, OrderItemStatus.Processing);
  }

  Future<void> rejectPendingOrderItem(int orderId, int orderItemId) async {
    await _updateOrderItemStatus(orderId, orderItemId, OrderItemStatus.Rejected);
  }

  Future<void> completeProcessingOrderItem(int orderId, int orderItemId) async {
    await _updateOrderItemStatus(orderId, orderItemId, OrderItemStatus.Complete);
  }

  Future<void> completeOrderAsPaid(int orderId) async
  {

    await _onc.completeOrderAsPaid(orderId: orderId);

    Order order = orderList.where((order) => order.id == orderId).toList().first;
    order.status = OrderStatus.Complete;
    _orderList = orderList.map((order) {
      if (order.id == orderId) {
        return order.copyWith(status: OrderStatus.Complete);
      }
      return order;
    }).toList();
    listenableOrderList.assignAll(_orderList);
  }

  Future<void> completeOrdersWithSessionId({required String sessionId}) async {
    List<Order> orders = orderList.where((order) => order.sessionId == sessionId).toList();
    for (Order order in orders) {
      if (order.status == OrderStatus.Pending_Payment) {
        await completeOrderAsPaid(order.id);
      }
      else
        {
          throw Exception('Order not yet pending payment'); //never thrown
        }
    }
  }
}
