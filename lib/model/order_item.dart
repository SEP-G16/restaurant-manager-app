import 'package:restaurant_manager/enum/order_item_status.dart';
import 'package:restaurant_manager/model/order_add_on.dart';

class OrderItem {
  final int id;
  final String menuItemName;
  final List<OrderAddOn>
      addOns; //might need to implement a custom class for this
  final String additionalNotes;
  final int quantity;
  OrderItemStatus status;

  OrderItem({
    required this.id,
    required this.menuItemName,
    required this.addOns,
    required this.additionalNotes,
    required this.quantity,
    required this.status,
  });

  String generateAddOnNote() {
    if (addOns.isNotEmpty) {
      return addOns.map((addOn) => '${addOn.name} x ${addOn.quantity}').join(', ');
    }
    return '';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menuItemName': menuItemName,
      'addOns': addOns.map((addOn) => addOn.toMap()).toList(),
      'additionalNotes': additionalNotes,
      'quantity': quantity,
      'status' : status.toString().split('.').last,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      menuItemName: map['menuItemName'],
      addOns: List<OrderAddOn>.from(map['addOns']?.map((addOn) => OrderAddOn.fromMap(addOn))),
      additionalNotes: map['additionalNotes'],
      quantity: map['quantity'],
      status: OrderItemStatus.values.where((stat) => stat.toString().toLowerCase().split('.').last == map['status'].toString().toLowerCase()).toList().first,
    );
  }

  OrderItem copyWith({
    int? id,
    String? menuItemName,
    List<OrderAddOn>? addOns,
    String? additionalNotes,
    int? quantity,
    OrderItemStatus? status,
  }) {
    return OrderItem(
      id: id ?? this.id,
      menuItemName: menuItemName ?? this.menuItemName,
      addOns: addOns ?? this.addOns,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status
    );
  }
}
