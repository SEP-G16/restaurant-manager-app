import 'order_item.dart';
import '../enum/order_status.dart';

class Order{
  final int id;
  final int tableNo;
  final List<OrderItem> orderItems;
  final double totalAmount;
  final OrderStatus status;

  Order(
      {required this.id, required this.tableNo, required this.orderItems, required this.totalAmount, required this.status,});
}