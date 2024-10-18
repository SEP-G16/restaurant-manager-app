import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/extension/date_time_extension.dart';
import 'package:http/http.dart' as http;

import '../../constants/network_constants.dart';
import '../../exception/token_expired_exception.dart';
import '../../exception/token_not_found_exception.dart';

class ReservationNetworkController extends GetxController {
  static final ReservationNetworkController instance = Get.find();

  final AuthController _authController = AuthController.instance;

  Future<List<Map<String, dynamic>>> fetchAvailableTables(
      {required DateTime date,
      required int timeSlotStart,
      required int timeSlotEnd}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/available'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'selectedDate': date.toIsoFormattedDateTime(),
          'timeSlotStart': timeSlotStart,
          'timeSlotEnd': timeSlotEnd
        }),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to fetch available tables');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchReservationsByDate(
      DateTime selectedDate) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/reservation/by-date?date=${selectedDate.toIsoFormattedDateTime()}'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to fetch reservations by date');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addReservation({required Map<String, dynamic> reservationMap}) async {
    print(reservationMap);
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/reservation/add'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(reservationMap),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 201) {
        print(response.body);
        throw NetworkException('Failed to create reservation');
      }
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }
}
