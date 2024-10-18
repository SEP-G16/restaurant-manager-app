import 'package:flutter/material.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';
import 'package:restaurant_manager/controller_initializer.dart';
import 'package:restaurant_manager/views/front_desk/reservation_screen.dart';
import 'package:restaurant_manager/views/kitchen_staff/order/order_main_screen.dart';
import 'package:restaurant_manager/views/login_screen.dart';

import '../enum/role.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<String> initControllers() async {
    try {
      if (!ControllerInitializer.initialized) {
        await ControllerInitializer.initAllControllers();
      }
      return 'Done';
    } catch (e) {
      print('Error loading controllers');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initControllers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (AuthController.instance.hasRole([Role.ROLE_ADMIN])) {
            return ReservationScreen();
          }

          if (AuthController.instance.hasRole([Role.ROLE_CHEF])) {
            return OrderMainScreen();
          }

          if (AuthController.instance.hasRole([
            Role.ROLE_RESTAURANT_MANAGER,
          ])) {
            return ReservationScreen();
          }

          if (AuthController.instance.hasRole([Role.ROLE_FRONT_DESK])) {
            return ReservationScreen();
          }

          Future<String> wait() async {
            await Future.delayed(const Duration(seconds: 5));
            return '';
          }

          return FutureBuilder(
              future: wait(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  AuthController.instance.logout();
                  return LoginScreen();
                } else {
                  return Scaffold(
                    body: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'You are unauthorized to access this app!\nYou\'ll be redirected to the Login Page',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ),
                    ),
                  );
                }
              });
        } else if (snapshot.hasError) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'An unexpected error occurred!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
