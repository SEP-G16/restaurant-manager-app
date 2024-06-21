import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/views/loading_screen.dart';

void main() {
  runApp(const RestaurantManager());
}

class RestaurantManager extends StatelessWidget {
  const RestaurantManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Waiter',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoadingScreen(),
    );
  }
}

