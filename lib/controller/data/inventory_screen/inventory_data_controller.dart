import 'package:get/get.dart';
import 'package:restaurant_manager/controller/network/inventory_network_controller.dart';

import '../../../model/inventory_item.dart';

class InventoryDataController extends GetxController {

  static InventoryDataController instance = Get.find();

  final InventoryNetworkController _inc = InventoryNetworkController.instance;

  List<InventoryItem> _inventoryList = <InventoryItem>[];
  List<InventoryItem> get inventoryList => _inventoryList;
  RxList<InventoryItem> listenableInventoryList = <InventoryItem>[].obs;

  InventoryDataController._();

  static Future<InventoryDataController> create() async {
    InventoryDataController controller = InventoryDataController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    await _fetchInventory();
  }

  Future<void> _fetchInventory() async {
    try {
      List<Map<String, dynamic>> inventoryList = await _inc.fetchInventory();
      List<InventoryItem> formattedList = inventoryList.map((itemMap) => InventoryItem.fromMap(itemMap)).toList();
      _inventoryList = formattedList;
      listenableInventoryList.assignAll(formattedList);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateStockStatus({required int itemId, required bool stockAvailable}) async {
    //network call
    List<InventoryItem> originalItemList = _inventoryList;
    InventoryItem item = originalItemList.firstWhere((item) => item.id == itemId);
    item.isInStock = stockAvailable;
    _inventoryList = originalItemList;
    listenableInventoryList.assignAll(originalItemList);
  }
}
