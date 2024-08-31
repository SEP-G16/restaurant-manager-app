import 'package:get/get.dart';

import '../../model/inventory_item.dart';

class InventoryController extends GetxController {
  var inventory = <InventoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with some sample data
    inventory.addAll([
      InventoryItem(id : 1, name: 'Chicken Bun', isInStock: true),
      InventoryItem(id : 1, name: 'Chicken Dumpling', isInStock: true),
      InventoryItem(id : 1, name: 'Soup', isInStock: false),
      InventoryItem(id : 1, name: 'Cake', isInStock: false),
    ]);
  }

  void markAsInStock(String itemName) {
    InventoryItem item = inventory.firstWhere((i) => i.name == itemName);
    item.isInStock = true;
    update(); // Notify listeners
  }

  void markAsOutOfStock(String itemName) {
    InventoryItem item = inventory.firstWhere((i) => i.name == itemName);
    item.isInStock = false;
    update(); // Notify listeners
  }
}
