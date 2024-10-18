import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/inventory_screen/inventory_data_controller.dart';
import 'package:restaurant_manager/enum/menu_item_status.dart';
import 'package:restaurant_manager/model/inventory_item.dart';

class InventoryScreenStateController extends GetxController {
  static InventoryScreenStateController instance = Get.find();

  final InventoryDataController _idc = InventoryDataController.instance;

  RxList<InventoryItem> _invenoryList = <InventoryItem>[].obs;
  List<InventoryItem> get inventoryList => _invenoryList.toList();
  RxList<InventoryItem> _displayedInventoryList = <InventoryItem>[].obs;
  List<InventoryItem> get displayedInventoryList =>
      _displayedInventoryList.toList();

  RxString _selectedDropDownOption = 'All'.obs;
  String get selectedDropDownOption => _selectedDropDownOption.value;
  set selectedDropDownOption(String value) {
    _selectedDropDownOption.value = value;
    if (value == 'All') {
      _displayedInventoryList.assignAll(_invenoryList);
    }
    else if(value == 'In Stock'){
      _displayedInventoryList.assignAll(_invenoryList.where((item) => item.status == MenuItemStatus.InStock).toList());
    }
    else if(value == 'Out of Stock'){
      _displayedInventoryList.assignAll(_invenoryList.where((item) => item.status == MenuItemStatus.OutOfStock).toList());
    }
  }

  Future<void> updateStockStatus(
      {required int itemId, required MenuItemStatus status}) async {
    await _idc.updateStockStatus(
        itemId: itemId, status: status);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _invenoryList.assignAll(_idc.inventoryList);
    _selectedDropDownOption.value = 'All';
    _displayedInventoryList.assignAll(_invenoryList);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_idc.listenableInventoryList, (invList) {
      _invenoryList.assignAll(invList);
      _selectedDropDownOption.value = 'All';
      _displayedInventoryList.assignAll(_invenoryList);
    });
  }
}
