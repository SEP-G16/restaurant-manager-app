import 'package:restaurant_manager/enum/order_item_status.dart';
import 'package:restaurant_manager/model/menu_item.dart';
import 'package:restaurant_manager/model/order_add_on.dart';

class OrderItem {
  final int id;
  final MenuItem menuItem;
  final List<OrderAddOn> addOns;
  final String additionalNotes;
  final int quantity;
  OrderItemStatus status;
  double totalAmount;

  OrderItem({
    required this.id,
    required this.menuItem,
    required this.addOns,
    required this.additionalNotes,
    required this.quantity,
    required this.status,
    required this.totalAmount,
  });

  String generateAddOnNote() {
    if (addOns.isNotEmpty) {
      return addOns
          .map((addOn) =>
              '${menuItem.addOns.where((mAddOn) => mAddOn.id == addOn.addOnId).toList().first.name} x ${addOn.quantity}')
          .join(', ');
    }
    return 'None';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menuItem': menuItem,
      'addOns': addOns.map((addOn) => addOn.toMap()).toList(),
      'additionalNotes': additionalNotes,
      'quantity': quantity,
      'status': status.toString().split('.').last,
      'totalAmount': totalAmount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      menuItem: MenuItem.fromMap(map['menuItem']),
      addOns: List<OrderAddOn>.from(
          map['addOns']?.map((addOn) => OrderAddOn.fromMap(addOn))),
      additionalNotes: map['additionalNotes'] ?? '',
      quantity: map['quantity'],
      status: OrderItemStatus.values
          .where((stat) =>
              stat.toString().toLowerCase().split('.').last ==
              map['status'].toString().toLowerCase())
          .toList()
          .first,
      totalAmount: map['totalAmount'],
    );
  }

  OrderItem copyWith({
    int? id,
    MenuItem? menuItem,
    List<OrderAddOn>? addOns,
    String? additionalNotes,
    int? quantity,
    OrderItemStatus? status,
    double? totalAmount,
  }) {
    return OrderItem(
      id: id ?? this.id,
      menuItem: menuItem ?? this.menuItem,
      addOns: addOns ?? this.addOns,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
