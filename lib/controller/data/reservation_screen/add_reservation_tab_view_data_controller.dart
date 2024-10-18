import 'package:get/get.dart';
import 'package:restaurant_manager/constants/table_constants.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/reservation_data_controller_mixin.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/exception/null_map_key_exception.dart';
import 'package:restaurant_manager/model/reservation.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class AddReservationTabViewDataController extends GetxController with ReservationDataControllerMixin{
  static final AddReservationTabViewDataController instance = Get.find();

  final ReservationNetworkController _rnc =
      ReservationNetworkController.instance;

  AddReservationTabViewDataController._();

  static Future<AddReservationTabViewDataController> create() async {
    final AddReservationTabViewDataController controller =
        AddReservationTabViewDataController._();

    Map<String, int> timeSlots = controller.getTimeSlotAsIntegerMap(DateTime.now());
    await controller.fetchAvailableTables(
        date: DateTime.now(),
        timeSlotStart: timeSlots['start']!,
        timeSlotEnd: timeSlots['end']!);
    return controller;
  }

  List<RestaurantTable> _availableTables = <RestaurantTable>[];
  List<RestaurantTable> get availableTables => _availableTables;
  final RxList<RestaurantTable> listenableAvailableTables =
      <RestaurantTable>[].obs;

  Future<List<RestaurantTable>> _fetchAvailableTables({
    required DateTime date,
    required int timeSlotStart,
    required int timeSlotEnd,
  }) async {
    List<RestaurantTable> dataList = [];
    try {
      List<Map<String, dynamic>> tableMapList = await _rnc.fetchAvailableTables(
        date: date,
        timeSlotStart: timeSlotStart,
        timeSlotEnd: timeSlotEnd,
      );

      try {
        _availableTables = tableMapList
            .map<RestaurantTable>(
                (tableMap) => RestaurantTable.fromMap(tableMap))
            .toList();
        listenableAvailableTables.assignAll(_availableTables);
      } on NullMapKeyException catch (e) {

        print(e.toString());
        rethrow;
      }
    } on NetworkException catch (e) {
      print(e.toString());
      rethrow;
    }
    return dataList;
  }

  Future<void> fetchAvailableTables({
    required DateTime date,
    required int timeSlotStart,
    required int timeSlotEnd,
  }) async {
    try {
      await _fetchAvailableTables(
          date: date, timeSlotStart: timeSlotStart, timeSlotEnd: timeSlotEnd);
    } on NetworkException catch (e) {
      //TODO:handle errors
    } on NullMapKeyException catch (e) {
      //TODO:handle errors
    }
  }

}
