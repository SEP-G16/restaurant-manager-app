import 'dart:convert';

import 'package:get/get.dart';

import '../../constants/network_constants.dart';
import '../../exception/network_exception.dart';
import '../../exception/token_expired_exception.dart';
import '../../exception/token_not_found_exception.dart';
import '../data/auth_controller.dart';
import 'package:http/http.dart' as http;

class TableDataNetworkController extends GetxController {
  final AuthController _authController = AuthController.instance;

  static TableDataNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getTables() async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/all'),
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

  Future<Map<String, dynamic>> addTable({required Map<String, dynamic> tableMap}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/add'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tableMap),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 201) {
        print(response.body);
        throw NetworkException('Failed to add table');
      }
      return jsonDecode(response.body);
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }
}
