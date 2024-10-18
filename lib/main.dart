import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/controller/network/auth_network_controller.dart';
import 'package:restaurant_manager/views/welcome_screen.dart';

import 'controller/data/secure_storage_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Get.put(SecureStorageController());
  Get.put(AuthNetworkController());
  runApp(const RestaurantManager());
  await Get.putAsync(() => AuthController.create());
}

class RestaurantManager extends StatelessWidget {
  const RestaurantManager({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Waiter',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: ColourConstants.gamboge,
          selectionColor: ColourConstants.gamboge,
          selectionHandleColor: ColourConstants.gamboge,
        ),
        canvasColor: ColourConstants.white,
        colorScheme: ColorScheme.light(primary: ColourConstants.gamboge),
      ),
      home: WelcomeScreen(),
    );
  }
}