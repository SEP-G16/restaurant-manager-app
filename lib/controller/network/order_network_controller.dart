import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurant_manager/constants/order_constants.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';

import '../../constants/network_constants.dart';
import '../../enum/order_item_status.dart';
import '../../exception/token_expired_exception.dart';
import '../../exception/token_not_found_exception.dart';

import 'package:http/http.dart' as http;

class OrderNetworkController extends GetxController {
  static OrderNetworkController get instance =>
      Get.isRegistered<OrderNetworkController>()
          ? Get.find<OrderNetworkController>()
          : Get.put(OrderNetworkController());

  final AuthController _authController = AuthController.instance;

  //fetch orders from "today" only & fetch orders with statuses
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/order/all'),
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
        throw NetworkException('Failed to fetch tables');
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

  Future<Map<String, dynamic>> updateOrderItemStatus({required int orderId, required int orderItemId, required OrderItemStatus orderItemStatus}) async
  {
    if (_authController.token == null) {
      await _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      String body = jsonEncode({
        'orderId': orderId,
        'orderItemId': orderItemId,
        'status': orderItemStatus.toString().split('.').last,
      });

      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/order/update-item-status'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to update order item status');
      }

      Map<String, dynamic> decoded = jsonDecode(response.body);
      return decoded;
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> completeOrderAsPaid({required int orderId}) async {
    if (_authController.token == null) {
      await _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/order/complete-order/$orderId'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to complete order');
      }

      Map<String, dynamic> decoded = jsonDecode(response.body);
      return decoded;
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }

  }
}
