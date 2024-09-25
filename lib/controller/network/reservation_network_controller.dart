import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager/constants/reservations_constants.dart';
import 'package:restaurant_manager/constants/table_constants.dart';
import 'package:restaurant_manager/exception/network_exception.dart';

class ReservationNetworkController extends GetxController {
  static final ReservationNetworkController instance = Get.find();

  Future<Map<String, dynamic>> fetchAvailableTables(
      {required DateTime date,
      required int timeSlotStart,
      required int timeSlotEnd}) async {
    try {
      //simulating network delay
      await Future.delayed(Duration(seconds: 1));
      Map<String, dynamic> dataMap = {};

      dataMap = {
        'date': '${date.year}-${date.month}-${date.day}',
        'time_slot_start': 8,
        'time_slot_end': 10,
        'available_tables':
            TableConstants.tableList.map((table) => table.toMap()).toList(),
      };
      return dataMap;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchReservationsByDate(
      DateTime selectedDate) async {
    ///Expected JSON format
    /*
    //   date : 2024-8-21,
    //   reservations : [
    //     {
    //       id : 1,
    //       customer_name : ,
    //       //for reserved date, we can get the date field from above
    //       people_count :
    //       phone_no :
    //       time_slot_start :
    //       time_slot_end :
    //       table_list : [{id : , table_no : , chair_count : }]
    //     },
    //   ]
    //    */
    try {
      //simulating network delay
      await Future.delayed(Duration(seconds: 1));
      Map<String, dynamic> dataMap = {};

      //adding dummy data
      dataMap['date'] =
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      dataMap['reservations'] = ReservationsConstants.reservations
          .where((reservation) =>
              reservation.reservedDate ==
              DateTime.parse(DateFormat('yyyy-MM-dd').format(selectedDate)))
          .toList()
          .map((reservation) => reservation.toMap())
          .toList();
      return dataMap;
    } on FormatException catch (e) {
      print('Format Exception Occurs');
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<void> addReservation({required Reservation reservation}) async {
    try {
      //simulating network delay
      await Future.delayed(Duration(seconds: 1));
      ReservationsConstants.reservations.add(reservation);
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
