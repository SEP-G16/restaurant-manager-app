import 'package:get/get.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class ReservationScreenDataController extends GetxController {
  static final ReservationScreenDataController instance = Get.find();

  final RxList<RestaurantTable> _allRestaurantTables = <RestaurantTable>[].obs;
  List<RestaurantTable> get allRestaurantTables => _allRestaurantTables;

  final RxList<RestaurantTable> _displayedTables = <RestaurantTable>[].obs;
  List<RestaurantTable> get displayedTables => _displayedTables;

  final RxList<RestaurantTable> _selectedTables = <RestaurantTable>[].obs;
  List<RestaurantTable> get selectedTables => _selectedTables;

  void _initController() {
    List<RestaurantTable> tableList = [
      RestaurantTable(id: 1, tableId: 101, chairCount: 4),
      RestaurantTable(id: 2, tableId: 102, chairCount: 6),
      RestaurantTable(id: 3, tableId: 103, chairCount: 2),
      RestaurantTable(id: 4, tableId: 104, chairCount: 8),
      RestaurantTable(id: 5, tableId: 105, chairCount: 4),
    ];
    _allRestaurantTables.value = tableList;
    _displayedTables.value = tableList;
  }

  void changeDisplayedTables(int chairCount) {
    if (chairCount == -1) {
      _displayedTables.value = _allRestaurantTables;
      return;
    }
    _displayedTables.value = _allRestaurantTables
        .where((table) => table.chairCount == chairCount)
        .toList();
  }

  ///id - id field in Table. Not tableId
  void addOrRemoveSelectedTable({required int id, bool remove = false}) {
    if (remove) {
      if (_selectedTables.any((table) => table.id == id)) {
        _selectedTables.removeWhere((table) => table.id == id);
      }else{
        // throw error and handle it in the UI if necessary
      }
    } else {
      if (_allRestaurantTables.any((table) => table.id == id)) {
        RestaurantTable table = _allRestaurantTables.where((table) => table.id == id).toList().first;
        _selectedTables.add(table);
      }else{
        // throw error and handle it in the UI if necessary
      }
    }
  }

  //id - table's id. Not table number
  bool checkTableSelected({required int id})
  {
    return _selectedTables.any((table) => table.id == id);
  }

  void reInit()
  {
    _displayedTables.value = _allRestaurantTables;
    _selectedTables.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _initController();
    super.onInit();
  }
}
