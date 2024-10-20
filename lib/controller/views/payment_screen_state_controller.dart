import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/order_screen/order_data_controller.dart';
import 'package:restaurant_manager/enum/order_item_status.dart';
import 'package:restaurant_manager/enum/order_status.dart';
import 'package:restaurant_manager/model/payment_pending_session.dart';

import '../../model/order.dart';

class PaymentScreenStateController extends GetxController {
  static PaymentScreenStateController instance = Get.find();

  final OrderDataController _odc = OrderDataController.instance;

  RxList<PaymentPendingSession> _sessions = <PaymentPendingSession>[].obs;

  List<PaymentPendingSession> get sessions => _sessions;

  List<PaymentPendingSession> _generateList(List<Order> orderList)
  {
    Map<String, List<Order>> sessionOrdersMap = {};

    for (Order order in orderList) {
      if (!sessionOrdersMap.containsKey(order.sessionId)) {
        sessionOrdersMap[order.sessionId] = [];
      }
      sessionOrdersMap[order.sessionId]!.add(order);
    }

    bool orderValidator(MapEntry<String, List<Order>> entry){
      List<Order> orderList = entry.value;

      bool allCancelled = orderList.every((order) => order.status == OrderStatus.Cancelled);
      bool anyPending = orderList.any((order) => order.status == OrderStatus.Pending);
      bool anyProcessing = orderList.any((order) => order.status == OrderStatus.Processing);
      bool anyComplete = orderList.any((order) => order.status == OrderStatus.Complete);

      if(anyPending || anyProcessing || allCancelled || anyComplete)
        {
          return false;
        }
      return true;
    }

    return sessionOrdersMap.entries
        .where(orderValidator)
        .map((entry) => PaymentPendingSession(sessionId: entry.key, orderList: entry.value))
        .toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    List<Order> orderList = _odc.orderList;
    _sessions.assignAll(_generateList(orderList));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    debounce(_odc.listenableOrderList, (orderList){
      _sessions.assignAll(_generateList(orderList));
    });
  }

  Future<void> getSessions() async {
    List<Order> orderList = _odc.orderList;
    _sessions.assignAll(_generateList(orderList));
  }

  Future<void> updateSessionAsComplete({required String sessionId}) async {
    await _odc.completeOrdersWithSessionId(sessionId: sessionId);
  }
}
