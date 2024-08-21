import 'package:get/get.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/exception/null_map_key_exception.dart';
import 'package:restaurant_manager/model/reservation.dart';

class ViewReservationsTabViewDataController extends GetxController {
  static final ViewReservationsTabViewDataController instance = Get.find();

  ViewReservationsTabViewDataController._();

  final ReservationNetworkController _rnc =
      ReservationNetworkController.instance;

  RxList<Reservation> _allReservationsByDate = <Reservation>[].obs;
  List<Reservation> get allReservationsByDate => _allReservationsByDate;
  RxList<Reservation> listenableAllReservationsByDate = <Reservation>[].obs;

  static Future<ViewReservationsTabViewDataController> create() async {
    final controller = ViewReservationsTabViewDataController._();
    await controller._init();
    return controller;
  }

  Future<void> _init() async {
    try {
      _allReservationsByDate.value = await _handleDateChange(DateTime.now());
      listenableAllReservationsByDate = _allReservationsByDate;
    }on FormatException catch(e){
      print('Format Exception caught');
    } on NetworkException catch (e) {
      print('Error fetching reservations : ${e}');
      //show dialog
    } on NullMapKeyException catch (e) {
      print('Null key error in _init in ViewReservationsTabViewDataController');
      //show appropriate dialog
    }
  }

  Future<List<Reservation>> _handleDateChange(DateTime selectedDate) async {
    Map<String, dynamic> dataMap =
        await _rnc.fetchReservationsByDate(selectedDate);
    if (dataMap['reservations'] == null) {
      throw NullMapKeyException(message: 'NULL Key \'reservations\'');
    }

    if (dataMap['reservations'] is List<Map<String, dynamic>>) {
      print('Is');
    }

    return (dataMap['reservations'] as List<Map<String, dynamic>>)
        .map((reservationMap) => Reservation.fromMap(reservationMap))
        .toList();
  }

  Future<void> handleDateChange({required DateTime selectedDate}) async {
    try {
      _allReservationsByDate.value = await _handleDateChange(selectedDate);
      print(_allReservationsByDate.value.toString());
      listenableAllReservationsByDate = _allReservationsByDate;
    } on NetworkException catch (e) {
      print('Error fetching reservations');
      //show dialog
    } on NullMapKeyException catch (e) {
      print('Null key error in _init in ViewReservationsTabViewDataController');
      //show appropriate dialog
    }
  }
}
