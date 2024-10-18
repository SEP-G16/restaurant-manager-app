import 'package:get/get.dart';
import 'package:restaurant_manager/controller/network/table_data_network_controller.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class TableDataController extends GetxController {
  static TableDataController instance = Get.find();

  final TableDataNetworkController _tdnc = TableDataNetworkController.instance;

  List<RestaurantTable> _tableList = [];

  List<RestaurantTable> get tableList => _tableList;
  RxList<RestaurantTable> listenableTableList = <RestaurantTable>[].obs;

  TableDataController._();

  static Future<TableDataController> create() async {
    TableDataController controller = TableDataController._();
    await controller._initController();
    return controller;
  }

  Future<void> reInitController() async
  {
    await _initController();
  }

  Future<void> _initController() async {
    List<Map<String, dynamic>> tableMapList = await _tdnc.getTables();
    _tableList = tableMapList.map((e) => RestaurantTable.fromMap(e)).toList();
    listenableTableList.assignAll(_tableList);
  }

  Future<void> addTable({required int tableNo, required int chairCount}) async {
    Map<String, dynamic> tableMap = {
      'tableNo': tableNo,
      'chairCount': chairCount,
    };
    print(tableMap);
    Map<String, dynamic> response = await _tdnc.addTable(tableMap: tableMap);
    RestaurantTable table = RestaurantTable.fromMap(response);
    _tableList.add(table);
    listenableTableList.assignAll(_tableList);
  }
}
