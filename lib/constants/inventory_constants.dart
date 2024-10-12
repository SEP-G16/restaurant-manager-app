import 'package:restaurant_manager/model/inventory_item.dart';

class InventoryConstants {
  InventoryConstants._();

  static final List<InventoryItem> inventory = [
    InventoryItem(id : 1, name: 'Chicken Bun', isInStock: true),
    InventoryItem(id : 2, name: 'Chicken Dumpling', isInStock: true),
    InventoryItem(id : 3, name: 'Soup', isInStock: false),
    InventoryItem(id : 4, name: 'Cake', isInStock: false),
  ];
}