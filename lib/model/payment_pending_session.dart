import 'package:restaurant_manager/enum/order_status.dart';
import 'package:restaurant_manager/model/order.dart';

class PaymentPendingSession{
  String sessionId;
  List<Order> orderList;

  PaymentPendingSession({required this.sessionId, required this.orderList});

  int get tableNo => orderList.first.table.tableNo;

  double get totalAmount{
    double total = 0.0;
    total += orderList.fold(0, (previousValue, element) => previousValue + (element.status != OrderStatus.Cancelled ? element.totalAmount : 0));
    return total;
  }
}