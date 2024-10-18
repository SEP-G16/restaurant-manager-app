import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_manager/constants/network_constants.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/exception/token_expired_exception.dart';
import 'package:restaurant_manager/exception/token_not_found_exception.dart';

import '../../enum/menu_item_status.dart';

class InventoryNetworkController extends GetxController {
  static InventoryNetworkController instance = Get.find();

  final AuthController _authController = AuthController.instance;

  Future<List<Map<String, dynamic>>> fetchInventory() async {
    try {
      var response =
          await http.get(Uri.parse('${NetworkConstants.baseUrl}/api/menu/all'));
      if (response.statusCode == 200) {
        return (jsonDecode(response.body))
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        throw NetworkException('Failed to fetch inventory');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateStockAvailabilityStatus(
      {required int itemId, required MenuItemStatus status}) async {
    if (_authController.token == null) {
      _authController.logout();
      throw TokenNotFoundException('Unable to find token');
    }

    try {
      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/menu/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.token}'
        },
        body: jsonEncode({
          'id': itemId,
          'status': status.asString,
        })
      );

      if(response.statusCode == 401)
        {
          _authController.logout();
          throw TokenExpiredException('Token not found');
        }

      if(response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to update stock status');
      }

      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
