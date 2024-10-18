import 'package:flutter/material.dart';
import 'package:restaurant_manager/controller/network/reservation_network_controller.dart';
import 'package:restaurant_manager/model/reservation.dart';
import 'package:get/get.dart';

mixin ReservationDataControllerMixin {

  List<String> _timeSlots = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
  ];
  List<String> get timeSlots => _timeSlots;


  ReservationNetworkController reservationNetworkController = ReservationNetworkController.instance;
  Future<void> addReservation({required Reservation reservation}) async {
    try{
      await reservationNetworkController.addReservation(reservationMap: reservation.toMap());
    }
    catch(e){
      print('Error adding reservation : $e');
      rethrow;
    }
  }

  String getTimeSlotAsString(DateTime dateTime){
    String timeSlot;
    if (dateTime.hour >= 22 || dateTime.hour < 8) {
      timeSlot = _timeSlots.first;
    } else {
      int nextAvailableHour = ((dateTime.hour + 1) / 2).ceil() * 2;
      if (nextAvailableHour >= 24) {
        nextAvailableHour = nextAvailableHour - 24;
      }
      if (nextAvailableHour >= 22 || dateTime.hour < 8) {
        timeSlot = _timeSlots.first;
      } else {
        String slot = '${nextAvailableHour.toString().padLeft(2, '0')}:00 - ${(nextAvailableHour + 2).toString().padLeft(2, '0')}:00';
        timeSlot = _timeSlots.firstWhere((s) => s == slot, orElse: () => _timeSlots.first);
      }
    }
    return timeSlot;
  }

  Map<String, int> getTimeSlotAsIntegerMap(DateTime dateTime){
    String timeSlot = getTimeSlotAsString(dateTime);
    int start = int.parse(timeSlot.substring(0, 2));
    int end = int.parse(timeSlot.substring(8,10));
    Map<String, int> timeSlotMap = {
      'start': start,
      'end': end
    };
    return timeSlotMap;
  }
}
