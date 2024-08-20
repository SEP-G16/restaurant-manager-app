import 'package:get/get.dart';

class InventoryItem {
  final String name;
  bool isInStock;

  InventoryItem({required this.name, required this.isInStock});
}

class InventoryController extends GetxController {
  var inventory = <InventoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with some sample data
    inventory.addAll([
      InventoryItem(name: 'Chicken Bun', isInStock: true),
      InventoryItem(name: 'Chicken Dumpling', isInStock: true),
      InventoryItem(name: 'Soup', isInStock: false),
      InventoryItem(name: 'Cake', isInStock: false),
    ]);
  }

  void markAsInStock(String itemName) {
    var item = inventory.firstWhere((i) => i.name == itemName);
    item.isInStock = true;
    update(); // Notify listeners
  }

  void markAsOutOfStock(String itemName) {
    var item = inventory.firstWhere((i) => i.name == itemName);
    item.isInStock = false;
    update(); // Notify listeners
  }
}
