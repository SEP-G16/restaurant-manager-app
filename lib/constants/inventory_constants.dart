import 'package:restaurant_manager/enum/menu_item_status.dart';
import 'package:restaurant_manager/model/inventory_item.dart';

class InventoryConstants {
  InventoryConstants._();

  static final List<InventoryItem> inventory = [
    InventoryItem(id : 1, name: 'Chicken Bun', status: MenuItemStatus.InStock),
    InventoryItem(id : 2, name: 'Chicken Dumpling', status: MenuItemStatus.InStock),
    InventoryItem(id : 3, name: 'Soup', status: MenuItemStatus.OutOfStock),
    InventoryItem(id : 4, name: 'Cake', status: MenuItemStatus.OutOfStock),
  ];
}