import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/order_screen/order_data_controller.dart';
import 'package:restaurant_manager/model/order.dart';

class OrderScreenMainStateController extends GetxController {
  static OrderScreenMainStateController instance = Get.find();

  OrderDataController _odc = OrderDataController.instance;
  RxList<Order> _orderList = <Order>[].obs;
  List<Order> get orderList => _orderList.toList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _orderList.value = _odc.orderList;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_odc.listenableOrderList, (orderList) {
      _orderList.assignAll(orderList);
    });
  }

  Future<void> acceptPendingOrderItem(
      {required int orderId, required int orderItemId}) async {
    await _odc.acceptPendingOrderItem(orderId, orderItemId);
  }

  Future<void> rejectPendingOrderItem(
      {required int orderId, required int orderItemId}) async {
    await _odc.rejectPendingOrderItem(orderId, orderItemId);
  }

  Future<void> completeProcessingOrderItem({required int orderId, required int orderItemId}) async {
    await _odc.completeProcessingOrderItem(orderId, orderItemId);
  }
}
