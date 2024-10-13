import 'order_item.dart';
import '../enum/order_status.dart';

class Order {
  final int id;
  final int tableNo;
  final List<OrderItem> orderItems;
  final double totalAmount;
  final OrderStatus status;
  final DateTime orderTime;

  Order({
    required this.id,
    required this.tableNo,
    required this.orderItems,
    required this.totalAmount,
    required this.status,
    required this.orderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tableNo': tableNo,
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'orderTime': orderTime.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      tableNo: map['tableNo'],
      orderItems: List<OrderItem>.from(map['orderItems']?.map((item) => OrderItem.fromMap(item))),
      totalAmount: map['totalAmount'],
      status: OrderStatus.values.where((stat) => stat.toString().toLowerCase().split('.').last == map['status'].toString().toLowerCase()).toList().first,
      orderTime: DateTime.parse(map['orderTime']),
    );
  }

  Order copyWith({
    int? id,
    int? tableNo,
    List<OrderItem>? orderItems,
    double? totalAmount,
    OrderStatus? status,
    DateTime? orderTime,
  }) {
    return Order(
      id: id ?? this.id,
      tableNo: tableNo ?? this.tableNo,
      orderItems: orderItems ?? this.orderItems,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      orderTime: orderTime ?? this.orderTime,
    );
  }
}

