import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/reservation_data_controller_mixin.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/exception/null_map_key_exception.dart';
import 'package:restaurant_manager/model/reservation.dart';

class ViewReservationsTabViewDataController extends GetxController with ReservationDataControllerMixin {
  static final ViewReservationsTabViewDataController instance = Get.find();

  ViewReservationsTabViewDataController._();

  final ReservationNetworkController _rnc =
      ReservationNetworkController.instance;

  List<Reservation> _allReservationsByDate = <Reservation>[];
  List<Reservation> get allReservationsByDate => _allReservationsByDate;
  RxList<Reservation> listenableAllReservationsByDate  = <Reservation>[].obs;

  static Future<ViewReservationsTabViewDataController> create() async {
    final controller = ViewReservationsTabViewDataController._();
    await controller._init();
    return controller;
  }

  Future<void> _init() async {
    try {
      _allReservationsByDate = await _handleDateChange(DateTime.now());
      listenableAllReservationsByDate.assignAll(_allReservationsByDate);
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
    List<Map<String, dynamic>> reservationMapList =
        await _rnc.fetchReservationsByDate(selectedDate);
    return reservationMapList.map((map) => Reservation.fromMap(map)).toList();
  }

  Future<void> handleDateChange({required DateTime selectedDate}) async {
    try {
      _allReservationsByDate= await _handleDateChange(selectedDate);
      listenableAllReservationsByDate.assignAll(_allReservationsByDate);
    } on NetworkException catch (e) {
      print('Error fetching reservations');
      //show dialog
    } on NullMapKeyException catch (e) {
      print('Null key error in _init in ViewReservationsTabViewDataController');
      //show appropriate dialog
    }
  }


}
