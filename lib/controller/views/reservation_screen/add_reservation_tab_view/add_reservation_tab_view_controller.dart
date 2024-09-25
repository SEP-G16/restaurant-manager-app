import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/add_reservation_tab_view_data_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_date_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_drop_down_controller.dart';
import 'package:restaurant_manager/model/reservation.dart';

import '../../../../model/restaurant_table.dart';

class AddReservationTabViewController extends GetxController {
  static final AddReservationTabViewController instance = Get.find();

  late final AddReservationTabViewDataController _rsdc;

  AddReservationTabViewDateController _dateController =
      AddReservationTabViewDateController.instance;
  AddReservationTabViewDropDownController _dropDownController =
      AddReservationTabViewDropDownController.instance;

  final RxList<RestaurantTable> _displayedTables = <RestaurantTable>[].obs;
  List<RestaurantTable> get displayedTables => _displayedTables;

  final RxList<RestaurantTable> _selectedTables = <RestaurantTable>[].obs;
  List<RestaurantTable> get selectedTables => _selectedTables;

  void _initController() {
    _rsdc = AddReservationTabViewDataController.instance;
    _displayedTables.value = _rsdc.availableTables;
  }

  void _changeDisplayedTables(int chairCount) {
    if (chairCount == -1) {
      _displayedTables.value = _rsdc.availableTables;
      return;
    }
    _displayedTables.value = _rsdc.availableTables
        .where((table) => table.chairCount == chairCount)
        .toList();
  }

  ///id - id field in Table. Not tableId
  void addOrRemoveSelectedTable({required int id, bool remove = false}) {
    if (remove) {
      if (_selectedTables.any((table) => table.id == id)) {
        _selectedTables.removeWhere((table) => table.id == id);
      } else {
        // throw error and handle it in the UI if necessary
      }
    } else {
      if (_rsdc.availableTables.any((table) => table.id == id)) {
        RestaurantTable table = _rsdc.availableTables
            .where((table) => table.id == id)
            .toList()
            .first;
        _selectedTables.add(table);
      } else {
        // throw error and handle it in the UI if necessary
      }
    }
  }

  //id - table's id. Not table number
  bool checkTableSelected({required int id}) {
    return _selectedTables.any((table) => table.id == id);
  }

  void reInit() {
    _displayedTables.value = _rsdc.availableTables;
    _selectedTables.clear();
  }

  void _onTablesChanged(_) {
    _displayedTables.value = _rsdc.availableTables;
  }

  Future<void> addReservation(
      String customerFirstName,
      String? customerLastName,
      String customerPhoneNo,
      String? customerEmail,
      String timeSlot,
      int peopleCount) async {
    int timeSlotStart = int.parse(timeSlot.substring(0, 2));
    int timeSlotEnd = int.parse(timeSlot.substring(8, 10));
    await _rsdc.addReservation(
      reservation: Reservation(
        id: -1,
        customerName: '$customerFirstName $customerLastName',
        reservedDate: _dateController.selectedDate,
        peopleCount: peopleCount,
        phoneNo: customerPhoneNo,
        timeSlotStart: timeSlotStart,
        timeSlotEnd: timeSlotEnd,
        tableList: _selectedTables,
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _initController();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_rsdc.listenableAvailableTables, _onTablesChanged);

    ever(_dateController.listenableSelectedDate, (date) async {
      _dropDownController.setSelectedTimeSlotByDateTime(dateTime: date);
      Map<String, int> timeSlotMap =
          _dropDownController.getTimeSlotAsIntegerMap(date);
      print(timeSlotMap);
      await _rsdc.fetchAvailableTables(
          date: date,
          timeSlotStart: timeSlotMap['start']!,
          timeSlotEnd: timeSlotMap['end']!);
    });

    ever(_dropDownController.listenableSelectedTimeSlot, (timeSlot) async {
      await _rsdc.fetchAvailableTables(
          date: _dateController.selectedDate,
          timeSlotStart: int.parse(timeSlot.substring(0, 2)),
          timeSlotEnd: int.parse(timeSlot.substring(8, 10)));
    });

    ever(_dropDownController.listenableSelectedCount, (count) {
      _changeDisplayedTables(count);
    });
  }
}
