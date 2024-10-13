import 'package:restaurant_manager/enum/order_item_status.dart';
import 'package:restaurant_manager/model/order.dart';
import 'package:restaurant_manager/model/order_add_on.dart';
import 'package:restaurant_manager/model/order_item.dart';

import '../enum/order_status.dart';

class OrderConstants {
  OrderConstants._();

  static final List<Order> orders = [
  Order(
    id: 1,
    totalAmount: 5.99,
    tableNo: 1,
    orderItems: [
      OrderItem(
        id: 1,
        menuItemName: 'Avocado Toast',
        addOns: [
          OrderAddOn(id: 1, name: 'Extra Sauce', price: 1.49, quantity: 1),
        ],
        additionalNotes: 'Add some extra cheese',
        quantity: 1,
        status: OrderItemStatus.Pending
      ),
    ],
    status: OrderStatus.Pending,
    orderTime: DateTime.now().subtract(Duration(minutes: 10)),
  ),
  Order(
    id: 2,
    totalAmount: 10.99,
    tableNo: 2,
    orderItems: [
      OrderItem(
        id: 1,
        menuItemName: 'Avocado Toast',
        addOns: [
          OrderAddOn(id: 2, name: 'Maple Syrup', price: 0.99, quantity: 1),
        ],
        additionalNotes: 'No mayonnaise',
        quantity: 2,
        status: OrderItemStatus.Processing
      ),
      OrderItem(
        id: 2,
        menuItemName: 'Pancakes',
        addOns: [
          OrderAddOn(id: 2, name: 'Maple Syrup', price: 0.99, quantity: 1),
        ],
        additionalNotes: 'No butter',
        quantity: 2,
        status: OrderItemStatus.Pending
      ),
    ],
    status: OrderStatus.Processing,
    orderTime: DateTime.now().subtract(Duration(minutes: 9)),
  ),
  Order(
    id: 3,
    totalAmount: 8.99,
    tableNo: 3,
    orderItems: [
      OrderItem(
        id: 3,
        menuItemName: 'Omelette',
        addOns: [
          OrderAddOn(id: 3, name: 'Cheese', price: 1.00, quantity: 1),
        ],
        additionalNotes: 'Well done',
        quantity: 1,
        status: OrderItemStatus.Processing
      ),
    ],
    status: OrderStatus.Processing,
    orderTime: DateTime.now().subtract(Duration(minutes:8)),
  ),
];
}
