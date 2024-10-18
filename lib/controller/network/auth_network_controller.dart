import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/exception/network_exception.dart';
import 'package:restaurant_manager/exception/token_expired_exception.dart';
import 'package:restaurant_manager/exception/token_not_found_exception.dart';
import 'package:restaurant_manager/exception/unauthorized_exception.dart';
import 'package:http/http.dart' as http;

import '../../constants/network_constants.dart';

class AuthNetworkController extends GetxController {
  static AuthNetworkController instance = Get.find();

  Future<void> validateToken({required String token}) async {
    var response = await http.get(
      Uri.parse('${NetworkConstants.baseUrl}/api/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 401) {
      throw TokenExpiredException('Token expired');
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    String body = jsonEncode({
      'username': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse('${NetworkConstants.baseUrl}/api/auth/login'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      throw RequestUnauthorizedException('Failed to login with credentials');
    }

    if (response.statusCode != 200) {
      print(response.body);
      throw NetworkException('Failed to login');
    }

    Map<String, dynamic> decoded = jsonDecode(response.body);

    return decoded['token'];
  }

  Future<Map<String, dynamic>> getRole(String token) async {

    var response = await http.get(
      Uri.parse('${NetworkConstants.baseUrl}/api/auth/profile'),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    return jsonDecode(response.body);
  }
}
