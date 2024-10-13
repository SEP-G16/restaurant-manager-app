import 'package:flutter/material.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/model/reservation.dart';
import 'package:get/get.dart';

mixin ReservationDataControllerMixin {
  ReservationNetworkController reservationNetworkController = ReservationNetworkController.instance;
  Future<void> addReservation({required Reservation reservation}) async {
    try{
      await reservationNetworkController.addReservation(reservation: reservation);
    }
    catch(e){
      print('Error adding reservation : $e');
    }
  }
}
