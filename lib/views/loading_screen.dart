import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/controller_initializer.dart';
import 'package:restaurant_manager/views/front_desk/reservation_screen.dart';
import 'package:restaurant_manager/views/kitchen_staff/order/order_main_screen.dart';
import 'package:restaurant_manager/views/welcome_screen.dart';

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
            return OrderMainScreen();
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
                  child: Center(child: CircularProgressIndicator(color: Colors.amber,),)
                ),
              ),
            );
          }
        });
  }
}
