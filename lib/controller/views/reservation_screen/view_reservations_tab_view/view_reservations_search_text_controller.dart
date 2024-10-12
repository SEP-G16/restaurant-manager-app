import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/view_reservations_tab_view/view_reservations_tab_view_controller.dart';

class ViewReservationsSearchTextController extends GetxController{
  final Rx<String?> searchText = null.obs;

  static ViewReservationsSearchTextController instance = Get.find();

  void setSearchText({String? value})
  {
    searchText.value = value;
  }
}