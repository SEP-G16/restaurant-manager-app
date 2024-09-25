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
    await controller._fetchAvailableTables(
        date: DateTime.now(), timeSlotStart: 14, timeSlotEnd: 16);
    return controller;
  }

  final RxList<RestaurantTable> _availableTables = <RestaurantTable>[].obs;
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
      Map<String, dynamic> dataMap = await _rnc.fetchAvailableTables(
        date: date,
        timeSlotStart: timeSlotStart,
        timeSlotEnd: timeSlotEnd,
      );

      try {
        if (dataMap['available_tables'] == null) {
          throw NullMapKeyException(message: 'NULL Key \'available_tables\'');
        }
        _availableTables.value = dataMap['available_tables']!
            .map<RestaurantTable>(
                (tableMap) => RestaurantTable.fromMap(tableMap))
            .toList();

        listenableAvailableTables.value = dataMap['available_tables']!
            .map<RestaurantTable>(
                (tableMap) => RestaurantTable.fromMap(tableMap))
            .toList();
      } on NullMapKeyException catch (e) {
        //TODO:handle null key
        print(e.toString());
        rethrow;
      }
    } on NetworkException catch (e) {
      //TODO:handle network error
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
