import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/table/table_data_controller.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class TableScreenStateController extends GetxController {
  static TableScreenStateController instance = Get.find();

  final TableDataController _tdc = TableDataController.instance;

  RxList<RestaurantTable> _tableList = <RestaurantTable>[].obs;
  List<RestaurantTable> get tableList => _tableList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _tableList.assignAll(_tdc.tableList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_tdc.listenableTableList, (value){
      _tableList.assignAll(value);
    });
  }

  Future<void> addTable({required int tableNo, required int chairCount}) async {
    await _tdc.addTable(tableNo: tableNo, chairCount: chairCount);
  }

  Future<void> getTables() {
    return _tdc.reInitController();
  }

}