import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/view_reservations_tab_view_data_controller.dart';

import '../../../../model/reservation.dart';

class ViewReservationsTabViewController extends GetxController {
  static final ViewReservationsTabViewController instance = Get.find();

  late final ViewReservationsTabViewDataController _vrtvdc;

  late final TextEditingController searchController;

  RxList<Reservation> _displayedReservations = <Reservation>[].obs;
  List<Reservation> get displayedReservations => _displayedReservations;

  void _init() {
    _vrtvdc = ViewReservationsTabViewDataController.instance;
    _displayedReservations.value = _vrtvdc.allReservationsByDate;
    searchController = TextEditingController();
    print(_vrtvdc.allReservationsByDate);
  }

  Future<void> handleDateChange({required DateTime selectedDate}) async {
    await _vrtvdc.handleDateChange(selectedDate: selectedDate);
    searchController.text = '';
    //can add a try catch here if we want to separate UI from business logic
  }

  void handleSearch({String? searchText}) {
    if (searchText == null || searchText == '') {
      _displayedReservations.value = _vrtvdc.allReservationsByDate;
      return;
    }

    bool validator(Reservation reservation) {
      return reservation.customerName.toLowerCase().contains(searchText) ||
          reservation.phoneNo.contains(searchText);
    }

    _displayedReservations.value = _vrtvdc.allReservationsByDate
        .where((reservation) => validator(reservation))
        .toList();
  }

  void _onDataChange(List<Reservation> list)
  {
    _displayedReservations.value = list;
    print(_displayedReservations);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_vrtvdc.listenableAllReservationsByDate, _onDataChange);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();
  }
}
