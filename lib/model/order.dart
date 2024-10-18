import 'package:restaurant_manager/model/order_table.dart';

import 'order_item.dart';
import '../enum/order_status.dart';

class Order {
  final int id;
  final OrderTable table;
  final List<OrderItem> orderItems;
  OrderStatus _status = OrderStatus.Pending;
  final DateTime orderTime;
  String sessionId;

  OrderStatus get status => _status;
  set status(OrderStatus value) => _status = value;

  double get totalAmount =>  orderItems.fold(0, (previousValue, element) => previousValue + element.totalAmount);

  Order({
    required this.id,
    required this.table,
    required this.orderItems,
    required OrderStatus status,
    required this.orderTime,
    required this.sessionId,
  }){
    _status = status;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table': table.toMap(),
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
      'status': _status.toString().split('.').last,
      'orderTime': orderTime.toIso8601String(),
      'sessionId' : sessionId,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      table: OrderTable.fromMap(map['table']!),
      orderItems: List<OrderItem>.from(map['orderItems']?.map((item) => OrderItem.fromMap(item))),
      status: OrderStatus.fromString(map['status']),
      orderTime: DateTime.parse(map['orderTime']), sessionId: map['sessionId'],
    );
  }

  Order copyWith({
    int? id,
    OrderTable? table,
    List<OrderItem>? orderItems,
    OrderStatus? status,
    DateTime? orderTime,
    String? sessionId
  }) {
    return Order(
      id: id ?? this.id,
      table: table ?? this.table,
      orderItems: orderItems ?? this.orderItems,
      status: status ?? _status,
      orderTime: orderTime ?? this.orderTime,
      sessionId: this.sessionId
    );
  }
}

