import 'package:get/get.dart';
import 'package:restaurant_manager/constants/inventory_constants.dart';

class InventoryNetworkController extends GetxController{
  static InventoryNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> fetchInventory() async {

    //Add try catch logic here

    //Do a network call to fetch inventory
    return InventoryConstants.inventory.map((item) => item.toMap()).toList();
  }

  Future<void> changeStockAvailabilityStatus({required int itemId, required stockAvailable}) async {

  }
}